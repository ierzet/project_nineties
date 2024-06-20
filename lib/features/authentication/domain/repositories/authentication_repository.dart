import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';
import 'dart:io';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserDynamic>> isAuthenticated();
  Future<Either<Failure, String>> signUpEmailAndPassword(
      RegisterAuthentication credential);
  Future<Either<Failure, User>> loginEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserDynamic>> authenticateEmailAndPassword(
      LoginAuthentication credential);

  Future<Either<Failure, UserDynamic>> authenticateGoogleSignin();
  Future<Either<Failure, UserDynamic>> authenticateFacebookSignin();
  Future<String> getData();
  Future<Either<Failure, String>> onLogOut();
}
