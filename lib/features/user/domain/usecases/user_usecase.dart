import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/user/domain/repositories/user_repository.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

class UserUseCase {
  const UserUseCase({required this.repository});

  final UserRepository repository;

  Future<Either<Failure, List<UserAccountEntity>>> fetchUsers() async {
    final data = await repository.fetchUsers();
    return data;
  }

  Future<Either<Failure, String>> approvalUser(UserAccountEntity params) async {
    final dataModel = UserAccountModel.fromEntity(params);
    final data = await repository.approvalUser(dataModel);
    return data;
  }

  Future<Either<Failure, String>> registerUser(UserParams params) async {
    final data = await repository.registerUser(params);
    return data;
  }

  Stream<Either<Failure, List<UserAccountEntity>>> call() {
    return repository.getUsersStream();
  }

  Future<Either<Failure, String>> exportToExcel(
      List<UserAccountEntity> params) async {
    // Create a new Excel document
    final excel = Excel.createExcel();
    final sheetObject = excel['User View Details'];
    final cellStyle = CellStyle(fontFamily: getFontFamily(FontFamily.Calibri));
    cellStyle.underline = Underline.Single;

    // Adding header row
    sheetObject.appendRow(UserAccountModel.fromEntity(UserAccountEntity.empty)
        .toTextCellValueHeader());

    // Adding data rows
    for (var user in params) {
      var userModel = UserAccountModel.fromEntity(user);
      sheetObject.appendRow(userModel.toTextCellValueList());
    }

    return await repository.exportToExcel(excel);
  }

  Future<Either<Failure, String>> exportToCSV(
      List<UserAccountEntity> users) async {
    try {
      List<List<dynamic>> rows = [];

      // Add headers.
      rows.add(
          UserAccountModel.fromEntity(UserAccountEntity.empty).toCSVHeader());

      // Add data.
      for (var user in users) {
        rows.add(UserAccountModel.fromEntity(user).toCSVList());
      }

      // Convert rows to CSV.
      String csv = const ListToCsvConverter().convert(rows);

      // Convert CSV string to Uint8List.
      final Uint8List csvData = Uint8List.fromList(csv.codeUnits);

      return await repository.exportToCSV(csvData);
    } catch (e) {
      return left(const ExportToCSV('Failed to export to CSV'));
    }
  }
}
