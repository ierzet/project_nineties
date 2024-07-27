import 'dart:io' as io;
import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/data/datasources/local/authentication_local_datasource.dart';
import 'package:project_nineties/features/authentication/data/datasources/remote/authentication_remote_datasoure.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/user/data/models/user_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_params.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  AuthenticationRepositoryImpl(
      {required this.authenticationRemoteDataSource,
      required this.authenticationLocalDataSource});

  //event untuk  registrasi dengan email and password
  @override
  Future<Either<Failure, String>> signUpEmailAndPassword(
      AuthenticationParams params) async {
    try {
      //daftar user dan passsword email
      await authenticationRemoteDataSource.signUpEmailAndPassword(params);

      /* 1. jika daftar berhasil, maka ambil data user firebase auth 
         2. upload file avatar di firebase storage dan download url file nya
         3. update displayName dan photoURL(url file) user firebase auth*/
      await authenticationRemoteDataSource
          .uploadFileImageAndUpdateProfile(params);

      // //initiate data useraccount dari registrasi (true)
      await authenticationRemoteDataSource.initiateUserAccountFireStore(
          isInitiate: true);

      // /* 1. kirim email verifikasi
      //    2. logout
      //    3. mengembalikan string proses signup berhasil */
      final result =
          await authenticationRemoteDataSource.sendEmailNotification();

      //kirim status berhasil
      return right(result);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      return Left(
        SignUpWithEmailAndPasswordFailure(e.message),
      );
    } on FirebaseStorageFailure catch (e) {
      return Left(
        FirebaseStorageFailure(e.message),
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
      AuthenticationParams params) async {
    try {
      // signin email and password dengan mengembalikan data firebase user
      final currentUser = await authenticationRemoteDataSource
          .authenticateEmailAndPassword(params);

      // check data firebase user apakah sudah ada di user_account firestore?
      final snapshotUserAccount =
          await authenticationRemoteDataSource.getDataById(currentUser.uid);

      /*
      jika user snapshot account account ada di firestore maka,
      snapshot ditampung di user account modoel, sebaliknya jika 
      tidak maka data current user akan di insert ke user account firestore (false)
      kemudian kembalikan data user account
       */
      final userAccountModel = snapshotUserAccount.exists
          ? UserAccountModel.fromFirestore(snapshotUserAccount)
          : await authenticationRemoteDataSource.initiateUserAccountFireStore(
              isInitiate: false);

      //validasi approval user
      if (userAccountModel.isActive == false) {
        await authenticationRemoteDataSource.onLogOut();
        return const Left(
          LogInWithEmailAndPasswordFailure('User need approval from admin'),
        );
      }

      /* Jika is initiate true, ubah isInitiate menjadi false 
      untuk memastikan sudah pernah login*/
      if (userAccountModel.isInitiate == true) {
        await authenticationRemoteDataSource.initiateUserAccountFalseFireStore(
            userAccount: userAccountModel.copyWith(isInitiate: false));
      }

      //update user account ke shared preference lokal
      await authenticationLocalDataSource.updateAuthSharedPreference();

      //tampung data di user dynamic
      final userDynamic = UserDynamic(
        userEntity: UserModel.fromFirebaseUser(currentUser).toEntity(),
        userAccountEntity: userAccountModel.toEntity(),
      );

      //mengembalikan nilai user dynamic
      return right(userDynamic);
    } on LogInWithEmailAndPasswordFailure catch (e) {
      return Left(
        LogInWithEmailAndPasswordFailure(e.message),
      );
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SharedPreferenceFailure catch (e) {
      return Left(
        SharedPreferenceFailure(e.message),
      );
    } on io.SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  //event untuk sign in with google
  @override
  Future<Either<Failure, UserDynamic>> authenticateGoogleSignin() async {
    try {
      // signin google dengan mengembalikan data firebase user
      final currentUser =
          await authenticationRemoteDataSource.authenticateGoogleSignin();

      // check data firebase user apakah sudah ada di user_account firestore?
      final snapshotUserAccount =
          await authenticationRemoteDataSource.getDataById(currentUser.uid);

      /*
      jika user snapshot account account ada di firestore maka,
      snapshot ditampung di user account modoel, sebaliknya jika 
      tidak maka data current user akan di insert ke user account firestore (false)
      kemudian kembalikan data user account
       */
      final userAccountModel = snapshotUserAccount.exists
          ? UserAccountModel.fromFirestore(snapshotUserAccount)
          : await authenticationRemoteDataSource.initiateUserAccountFireStore(
              isInitiate: false,
            );

      // validasi untuk pertama kali login dengan gmail
      if (!snapshotUserAccount.exists) {
        await authenticationRemoteDataSource.onLogOut();
        return const Left(
          LogInWithEmailAndPasswordFailure('User need approval from admin'),
        );
      }

      //validasi approval user
      if (userAccountModel.isActive == false) {
        await authenticationRemoteDataSource.onLogOut();
        return const Left(
          LogInWithEmailAndPasswordFailure('User need approval from admin'),
        );
      }

      //update user account ke shared preference lokal
      await authenticationLocalDataSource.updateAuthSharedPreference();

      //tampung data di user dynamic
      final userDynamic = UserDynamic(
        userEntity: UserModel.fromFirebaseUser(currentUser).toEntity(),
        userAccountEntity: userAccountModel.toEntity(),
      );

      //kembalikan data user dynamic
      return right(userDynamic);
    } on LogInWithGoogleFailure catch (e) {
      return Left(
        LogInWithGoogleFailure(e.message),
      );
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SharedPreferenceFailure catch (e) {
      return Left(
        SharedPreferenceFailure(e.message),
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
      // signin google dengan mengembalikan data firebase user
      final currentUser =
          await authenticationRemoteDataSource.authenticateFacebookSignin();

      // check data firebase user apakah sudah ada di user_account firestore?
      final snapshotUserAccount =
          await authenticationRemoteDataSource.getDataById(currentUser.uid);

      /*
      jika user snapshot account account ada di firestore maka,
      snapshot ditampung di user account modoel, sebaliknya jika 
      tidak maka data current user akan di insert ke user account firestore (false)
      kemudian kembalikan data user account
       */
      final userAccountModel = snapshotUserAccount.exists
          ? UserAccountModel.fromFirestore(snapshotUserAccount)
          : await authenticationRemoteDataSource.initiateUserAccountFireStore(
              isInitiate: false);

      // validasi untuk pertama kali login dengan gmail,
      if (!snapshotUserAccount.exists) {
        await authenticationRemoteDataSource.onLogOut();
        return const Left(
          LogInWithEmailAndPasswordFailure('User need approval from admin'),
        );
      }

      //validasi approval user
      if (userAccountModel.isActive == false) {
        await authenticationRemoteDataSource.onLogOut();
        return const Left(
          LogInWithEmailAndPasswordFailure('User need approval from admin'),
        );
      }

      //update user account ke shared preference lokal
      await authenticationLocalDataSource.updateAuthSharedPreference();

      //tampung data di user dynamic
      final userDynamic = UserDynamic(
        userEntity: UserModel.fromFirebaseUser(currentUser).toEntity(),
        userAccountEntity: userAccountModel.toEntity(),
      );

      //kembalikan data user dynamic
      return right(userDynamic);
    } on LogInWithGoogleFailure catch (e) {
      return Left(
        LogInWithGoogleFailure(e.message),
      );
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SharedPreferenceFailure catch (e) {
      return Left(
        SharedPreferenceFailure(e.message),
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
