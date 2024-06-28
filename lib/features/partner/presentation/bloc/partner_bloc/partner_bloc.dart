import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';
import 'package:rxdart/rxdart.dart';
import 'package:universal_html/html.dart' as html;

part 'partner_event.dart';
part 'partner_state.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  PartnerBloc(this.usecase) : super(const PartnerInitial()) {
    on<AdminRegPartnerClicked>(_onAdminRegPartnerClicked,
        transformer: debounce(const Duration(milliseconds: 500)));
  }
  final PartnerUseCase usecase;

  void _onAdminRegPartnerClicked(
      AdminRegPartnerClicked event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());
    if (!event.params.isValid) {
      emit(const PartnerLoadFailure(AppStrings.dataIsNotValid));
      return;
    }
    final result = await usecase.insertData(event.params);
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(failure.message));
      },
      (data) {
        emit(PartnerLoadSuccess(data));
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

class PartnerUseCase {
  final PartnerRepository repository;

  const PartnerUseCase({required this.repository});

  Future<Either<Failure, String>> insertData(PartnerParams params) async {
    final dataModel = PartnerModel.fromParams(params);
    // print('usecase: $dataModel');
    //return Right('dataModel: $dataModel');
    return repository.insertData(dataModel);
  }
}

abstract class PartnerRepository {
  Future<Either<Failure, String>> insertData(
    PartnerModel dataModel,
  );
}

class PartnerRepositoryImpl implements PartnerRepository {
  final PartnerRemoteDataSource remoteDataSource;

  PartnerRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> insertData(
    PartnerModel dataModel,
  ) async {
    try {
      final result = await remoteDataSource.insertData(dataModel);
      return right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }
}

abstract class PartnerRemoteDataSource {
  Future<String> insertData(PartnerModel dataModel);
}

class PartnerRemoteDataSourceImpl implements PartnerRemoteDataSource {
  final FirebaseFirestore collection;
  final FirebaseStorage _firebaseStorage;

  PartnerRemoteDataSourceImpl(this.collection, this._firebaseStorage);

  @override
  Future<String> insertData(PartnerModel dataModel) async {
    try {
      String downloadUrl = '';

      //1 Check dataImage is not null

      if (kIsWeb && dataModel.partnerAvatarFileWeb != null) {
        final blob = html.Blob([dataModel.partnerAvatarFileWeb!]);
        //2 Upload dataImage to FirebaseStorage
        var snapshot = await _firebaseStorage
            .ref()
            .child(
                'user_image/partner_profile/${dataModel.partnerEmail}_${DateTime.now().millisecondsSinceEpoch}')
            .putBlob(blob);
        downloadUrl = await snapshot.ref.getDownloadURL();
      } else if (dataModel.partnerAvatarFile != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child(
                'user_image/partner_profile/${dataModel.partnerEmail}_${DateTime.now().millisecondsSinceEpoch}')
            .putFile(dataModel.partnerAvatarFile!);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      //3 Update url to dataModel
      dataModel = dataModel.copyWith(partnerImageUrl: downloadUrl);

      // 3. Check if document already exists
      var docRef = collection.collection('partner').doc(dataModel.partnerEmail);
      var docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return 'Data mitra sudah ada silakan gunakan email yang lain';
      }

      //4 Save dataModel to Firestore
      await docRef.set(dataModel.toFireStore());
      return 'Data mitra berhasil ditambahkan';
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('failed connect to the network');
    } catch (_) {
      throw const FireBaseCatchFailure();
    }
  }
}
