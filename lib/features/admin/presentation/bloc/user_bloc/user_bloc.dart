import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:rxdart/rxdart.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.usecase}) : super(UserInitial()) {
    on<UserGetData>(_onUserGetData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<UserUpdateData>(_onUserUpdateData,
        transformer: debounce(const Duration(milliseconds: 500)));
  }

  final UserUseCase usecase;

  void _onUserGetData(UserGetData event, Emitter<UserState> emit) async {
    emit(const UserLoadInProgress());

    final result = await usecase.fetchUsers();
    result.fold(
      (failure) {
        emit(UserLoadFailure(message: failure.message));
      },
      (data) {
        emit(UserLoadSuccess(data: data));
      },
    );
  }

  void _onUserUpdateData(UserUpdateData event, Emitter<UserState> emit) async {
    emit(const UserLoadInProgress());

    if (event.userAccountEntity.partner.partnerId == '' ||
        event.userAccountEntity.roleId == null ||
        event.userAccountEntity.roleId == '') {
      emit(const UserLoadFailure(message: 'partner or role should be filled'));
      return;
    }

    final navigatorBloc = event.context.read<NavigationCubit>();
    final result = await usecase.approvalUser(event.userAccountEntity.copyWith(
      updatedBy: event.updatedUser,
      updatedDate: DateTime.now(),
    ));

    result.fold(
      (failure) {
        emit(UserLoadFailure(message: failure.message));
      },
      (data) {
        //back to home
        navigatorBloc.updateIndex(0);
        emit(UserLoadApprovalSuccess(message: data));
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

class UserUseCase {
  const UserUseCase({required this.repository});

  final UserRepository repository;
  Future<Either<Failure, List<UserAccountEntity>>> fetchUsers() async {
    final data = await repository.fetchUsers();
    return data;
  }

  Future<Either<Failure, String>> approvalUser(UserAccountEntity params) async {
    final dataModel = UserAccountModel.fromEntity(params);
    final data = await repository.approvalUser(dataModel);
    return data;
  }
}

abstract class UserRepository {
  Future<Either<Failure, List<UserAccountEntity>>> fetchUsers();
  Future<Either<Failure, String>> approvalUser(UserAccountModel params);
}

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.remoteDataSource});

  final UserRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<UserAccountEntity>>> fetchUsers() async {
    try {
      final queryData = await remoteDataSource.fetchUsers();
      final result = queryData.docs
          .map((doc) => UserAccountModel.fromFirestore(doc))
          .toList();

      return Right(result);
    } catch (e) {
      // Handle exceptions and return appropriate failure
      return Left(FireBaseCatchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> approvalUser(UserAccountModel params) async {
    final data = await remoteDataSource.approvalUser(params);
    return Right(data);
  }
}

abstract class UserRemoteDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers();
  Future<String> approvalUser(UserAccountModel params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this.instance);
  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers() async {
    try {
      final result = await instance.collection('user_account').get();

      return result;
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('failed connect to the network');
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        rethrow;
      } else {
        throw const FireBaseCatchFailure();
      }
    }
  }

  @override
  Future<String> approvalUser(UserAccountModel params) async {
    try {
      await instance
          .collection('user_account')
          .doc(params.user.id)
          .set(params.approvalUser());
      return 'user ${params.user.name} has been approval';
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (_) {
      throw const FireBaseCatchFailure();
    }
  }
}
