import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_params.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, String>> signUpEmailAndPassword(
      AuthenticationParams params);
  Future<Either<Failure, UserDynamic>> authenticateEmailAndPassword(
      AuthenticationParams params);

  Future<Either<Failure, UserDynamic>> authenticateGoogleSignin();
  Future<Either<Failure, UserDynamic>> authenticateFacebookSignin();
  Future<Either<Failure, UserAccountEntity>> getUserAccountById(String uid);
  Future<Either<Failure, String>> onLogOut();
  Future<Either<Failure, String>> resetPassword(String email);
}
