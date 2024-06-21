import 'dart:io' as io;
import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/data/datasources/local/authentication_local_datasource.dart';
import 'package:project_nineties/features/authentication/data/datasources/remote/authentication_remote_datasoure.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  AuthenticationRepositoryImpl(
      {required this.authenticationRemoteDataSource,
      required this.authenticationLocalDataSource});

  //call the remote data source to sign up with email and password
  @override
  Future<Either<Failure, String>> signUpEmailAndPassword(
      RegisterAuthentication credential) async {
    try {
      final result = await authenticationRemoteDataSource
          .signUpEmailAndPassword(credential);
      return right(result);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      return Left(
        SignUpWithEmailAndPasswordFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  //call the remote data source to sign in with email and password
  @override
  Future<Either<Failure, UserDynamic>> authenticateEmailAndPassword(
      LoginAuthentication credential) async {
    try {
      final resultUserModel = await authenticationRemoteDataSource
          .authenticateEmailAndPassword(credential);

      final dataExist =
          await authenticationRemoteDataSource.getDataById(resultUserModel.id);

      final resultUserAccountModel = dataExist.exists
          ? UserAccountModel.fromFirestore(dataExist)
          : await authenticationRemoteDataSource.updateUserAccountFireStore();

      await authenticationLocalDataSource.updateAuthSharedPreference();

      final user = UserDynamic(
        userEntity: resultUserModel.toEntity(),
        userAccountEntity: resultUserAccountModel.toEntity(),
      );

      return right(user);
    } on LogInWithEmailAndPasswordFailure catch (e) {
      return Left(
        LogInWithEmailAndPasswordFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  //call the remote data source to sign in with google
  @override
  Future<Either<Failure, UserDynamic>> authenticateGoogleSignin() async {
    try {
      final resultUserModel =
          await authenticationRemoteDataSource.authenticateGoogleSignin();
      final dataExist =
          await authenticationRemoteDataSource.getDataById(resultUserModel.id);
      final resultUserAccountModel = dataExist.exists
          ? UserAccountModel.fromFirestore(dataExist)
          : await authenticationRemoteDataSource.updateUserAccountFireStore();
      await authenticationLocalDataSource.updateAuthSharedPreference();
      final user = UserDynamic(
        userEntity: resultUserModel.toEntity(),
        userAccountEntity: resultUserAccountModel.toEntity(),
      );

      return right(user);
    } on LogInWithGoogleFailure catch (e) {
      return Left(
        LogInWithGoogleFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, UserDynamic>> authenticateFacebookSignin() async {
    try {
      final resultUserModel =
          await authenticationRemoteDataSource.authenticateFacebookSignin();
      final dataExist =
          await authenticationRemoteDataSource.getDataById(resultUserModel.id);
      final resultUserAccountModel = dataExist.exists
          ? UserAccountModel.fromFirestore(dataExist)
          : await authenticationRemoteDataSource.updateUserAccountFireStore();
      await authenticationLocalDataSource.updateAuthSharedPreference();
      final user = UserDynamic(
        userEntity: resultUserModel.toEntity(),
        userAccountEntity: resultUserAccountModel.toEntity(),
      );

      return right(user);
    } on LogInWithGoogleFailure catch (e) {
      return Left(
        LogInWithGoogleFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  //call the remote data source to log out
  @override
  Future<Either<Failure, String>> onLogOut() async {
    try {
      final result = await authenticationRemoteDataSource.onLogOut();

      return right(result);
    } on AuthInitializeFailure catch (e) {
      return Left(
        AuthInitializeFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, UserAccountEntity>> getUserAccountById(
      String uid) async {
    try {
      final result =
          await authenticationRemoteDataSource.getUserAccountById(uid);
      return right(result.toEntity());
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(String email) async {
    try {
      final result = await authenticationRemoteDataSource.resetPassword(email);
      return right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }
}
