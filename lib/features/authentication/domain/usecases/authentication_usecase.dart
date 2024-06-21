import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';

class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCase(this.authenticationRepository);

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

  Future<Either<Failure, UserAccountEntity>> getUserAccountById(String uid) {
    return authenticationRepository.getUserAccountById(uid);
  }

  // Log out the user
  Future<Either<Failure, String>> onLogOut() {
    return authenticationRepository.onLogOut();
  }

  Future<Either<Failure, String>> resetPassword(String email) {
    return authenticationRepository.resetPassword(email);
  }
}
