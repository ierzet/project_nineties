import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserAccountEntity>>> fetchUsers();
  Future<Either<Failure, String>> approvalUser(UserAccountModel params);
  Future<Either<Failure, String>> registerUser(UserParams params);
  Stream<Either<Failure, List<UserAccountEntity>>> getUsersStream();
  Future<Either<Failure, String>> exportToExcel(Excel params);
  Future<Either<Failure, String>> exportToCSV(Uint8List params);
}
