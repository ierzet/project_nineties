import 'dart:convert';
import 'dart:io' as io;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/data/datasources/local/authentication_local_datasource.dart';
import 'package:project_nineties/features/authentication/data/datasources/remote/authentication_remote_datasoure.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';
import 'package:universal_html/html.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  AuthenticationRepositoryImpl(
      {required this.authenticationRemoteDataSource,
      required this.authenticationLocalDataSource});

  //call remote data source to check authentication status

  @override
  Future<Either<Failure, UserDynamic>> isAuthencticated() async {
    try {
      final resultUserModel =
          await authenticationRemoteDataSource.isAuthencticated();
      final userAccountString = await authenticationLocalDataSource.getData();
      final user = resultUserModel.isEmpty
          ? UserDynamic.empty
          : UserDynamic(
              userEntity: resultUserModel.toEntity(),
              userAccountEntity: userAccountString == null
                  ? UserAccountModel.empty
                  : UserAccountModel.fromJson(json.decode(userAccountString))
                      .toEntity(),
            );

      return right(user);
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

  //call the remote data source to sign up with email and password
  @override
  Future<Either<Failure, String>> signUpEmailAndPassword(
      RegisterAuthentication credential, File? imageData) async {
    try {
      final result = await authenticationRemoteDataSource
          .signUpEmailAndPassword(credential, imageData);
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
  Future<Either<Failure, User>> loginEmailAndPassword(
      String email, String password) async {
    try {
      final result = await authenticationRemoteDataSource.loginEmailAndPassword(
          email, password);

      return right(result);
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

  @override
  Future<String> getData() async {
    try {
      final result = await authenticationLocalDataSource.getData();
      return result;
    } on ServerFailure catch (e) {
      return e.message;
    }
  }
}
