import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/user/data/datasources/local/user_local_datasource.dart';
import 'package:project_nineties/features/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:project_nineties/features/user/domain/repositories/user_repository.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  @override
  Stream<Either<Failure, List<UserAccountEntity>>> getUsersStream() {
    return remoteDataSource
        .getUsersStream()
        .map<Either<Failure, List<UserAccountEntity>>>(
      (users) {
        return Right(users);
      },
    ).handleError((error) {
      if (error is FirebaseException) {
        switch (error.code) {
          case 'permission-denied':
            return const Left(FirebaseStorageFailure(
                'User does not have permission to access this data.'));
          case 'unavailable':
            return const Left(ConnectionFailure('Network is unavailable.'));
          case 'cancelled':
            return const Left(FirebaseStorageFailure('Request was cancelled.'));
          default:
            return Left(
                ServerFailure('An unknown error occurred: ${error.message}'));
        }
      } else if (error is SocketException) {
        return const Left(ConnectionFailure('No Internet connection.'));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    });
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

  @override
  Future<Either<Failure, String>> exportToExcel(Excel params) async {
    try {
      final result = await localDataSource.exportToExcel(params);
      return Right(result);
    } catch (e) {
      return Left(ExportToExcel(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> exportToCSV(Uint8List params) async {
    try {
      final result = await localDataSource.exportToCSV(params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
