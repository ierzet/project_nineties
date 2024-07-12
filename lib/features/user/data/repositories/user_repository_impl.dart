import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/user/data/datasources/user_remote_datasource.dart';
import 'package:project_nineties/features/user/domain/repositories/user_repository.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.remoteDataSource});

  final UserRemoteDataSource remoteDataSource;

  @override
  Stream<Either<Failure, List<UserAccountEntity>>> getUsersStream() {
    return remoteDataSource
        .getUsersStream()
        .map<Either<Failure, List<UserAccountEntity>>>(
      (users) {
        return Right(users);
      },
    ).handleError((error) {
      return Left(ServerFailure(error.toString()));
    });
    //TODO:rapihin handler error nya
  }

  @override
  Future<Either<Failure, List<UserAccountEntity>>> fetchUsers() async {
    try {
      final queryData = await remoteDataSource.fetchUsers();
      final result = queryData.docs
          .map((doc) => UserAccountModel.fromFirestore(doc))
          .toList();

      return Right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(FireBaseCatchFailure(e.toString()));
    } on ConnectionFailure catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> approvalUser(UserAccountModel params) async {
    try {
      final data = await remoteDataSource.approvalUser(params);
      return Right(data);
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (_) {
      throw const FireBaseCatchFailure();
    }
  }

  @override
  Future<Either<Failure, String>> registerUser(UserParams params) async {
    try {
      final data = await remoteDataSource.registerUser(params);

      return Right(data);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      return Left(
        SignUpWithEmailAndPasswordFailure(e.message),
      );
    } on FirebaseStorageFailure catch (e) {
      return Left(
        FirebaseStorageFailure(e.message),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }
}
