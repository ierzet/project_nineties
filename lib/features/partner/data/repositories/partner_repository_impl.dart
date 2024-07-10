import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/partner/data/datasources/partner_remote_datasource.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/repositories/pertner_repository.dart';

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
      // 1. Upload image
      final downloadUrl = await remoteDataSource.uploadImage(dataModel);
      dataModel = dataModel.copyWith(partnerImageUrl: downloadUrl);

      // 2. insert partner dataModel to firestrore
      final result = await remoteDataSource.insertData(dataModel);

      //3. mengembalikan  nilai string
      return Right(result);
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

  @override
  Future<Either<Failure, List<PartnerModel>>> fetchPartners() async {
    try {
      final queryData = await remoteDataSource.fetchPartners();
      final result =
          queryData.docs.map((doc) => PartnerModel.fromFirestore(doc)).toList();
      return Right(result);
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
