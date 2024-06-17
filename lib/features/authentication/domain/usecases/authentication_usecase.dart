import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';
import 'package:universal_html/html.dart';

class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCase(this.authenticationRepository);

  Future<Either<Failure, UserDynamic>> isAuthencticated() {
    return authenticationRepository.isAuthencticated();
  }

  Future<Either<Failure, UserDynamic>> authenticateEmailAndPassword(
      String email, String password) {
    final credential = LoginAuthentication(email: email, password: password);
    return authenticationRepository.authenticateEmailAndPassword(credential);
  }

  // Future<Either<Failure, User>> loginEmailAndPassword(
  //     RegisterAuthentication credential) {
  //   return authenticationRepository.loginEmailAndPassword(
  //       credential.email, credential.password);
  // }

  Future<Either<Failure, String>> register(
      RegisterAuthentication credential, File? imageData) async {
    // 1. Register user to firebase auth
    final registerResult =
        authenticationRepository.signUpEmailAndPassword(credential, imageData);

    //2. Login email and password
    //3. Upload file to firebase storage
    //4. Update user
    //5. Logout
    // authenticationRepository.onLogOut();
    return registerResult;
  }

  Future<Either<Failure, UserDynamic>> authenticateGoogleSignin() {
    return authenticationRepository.authenticateGoogleSignin();
  }

  Future<Either<Failure, UserDynamic>> authenticateFacebookSignin() {
    return authenticationRepository.authenticateFacebookSignin();
  }

  Future<String> getData() {
    return authenticationRepository.getData();
  }

  Future<Either<Failure, String>> onLogOut() {
    return authenticationRepository.onLogOut();
  }
}
