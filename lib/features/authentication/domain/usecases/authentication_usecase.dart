import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';
import 'dart:io';

class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCase(this.authenticationRepository);

  // Check if user is authenticated
  Future<Either<Failure, UserDynamic>> isAuthenticated() {
    return authenticationRepository.isAuthenticated();
  }

  // Authenticate user using email and password
  Future<Either<Failure, UserDynamic>> authenticateEmailAndPassword(
      String email, String password) {
    final credential = LoginAuthentication(email: email, password: password);
    return authenticationRepository.authenticateEmailAndPassword(credential);
  }

  // Register a new user
  Future<Either<Failure, String>> register(
    RegisterAuthentication credential,
  ) async {
    final registerResult =
        authenticationRepository.signUpEmailAndPassword(credential);
    return registerResult;
  }

  // Authenticate user using Google Sign-In
  Future<Either<Failure, UserDynamic>> authenticateGoogleSignIn() {
    return authenticationRepository.authenticateGoogleSignin();
  }

  // Authenticate user using Facebook Sign-In
  Future<Either<Failure, UserDynamic>> authenticateFacebookSignIn() {
    return authenticationRepository.authenticateFacebookSignin();
  }

  // Get additional user data
  Future<String> getData() {
    return authenticationRepository.getData();
  }

  // Log out the user
  Future<Either<Failure, String>> onLogOut() {
    return authenticationRepository.onLogOut();
  }
}
