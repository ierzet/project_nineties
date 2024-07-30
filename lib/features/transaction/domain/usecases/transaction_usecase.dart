import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/transaction/data/models/transaction_model.dart';
import 'package:project_nineties/features/transaction/domain/entities/transaction_entity.dart';
import 'package:project_nineties/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionUseCase {
  const TransactionUseCase({required this.repository});
  final TransactionRepository repository;

  Stream<Either<Failure, List<TransactionEntity>>> call() {
    return repository.getTransactionsStream();
  }

  Future<Either<Failure, CustomerEntity>> getCustomer(String param) async {
    final result = repository.getCustomer(param);
    return result;
  }

  Future<Either<Failure, List<TransactionEntity>>> fetchData() async {
    final listModelResult = await repository.fetchData();
    final listEnity = listModelResult
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEnity;
  }

  Future<Either<Failure, String>> addTransaction(
      {required CustomerEntity customerEntity,
      required UserAccountEntity userAccountEntity}) async {
    final paramModel = TransactionModel.empty.copyWith(
      user: userAccountEntity.user,
      partner: userAccountEntity.partner,
      customer: customerEntity,
      transactionDate: DateTime.now(),
      createdBy: userAccountEntity.user.id,
      createdDate: DateTime.now(),
    );
    final result = repository.addTransaction(paramModel);
    return result;
  }

  Future<Either<Failure, String>> exportToExcel(
      List<TransactionEntity> params) async {
    // Create a new Excel document
    final excel = Excel.createExcel();
    final sheetObject = excel['Transaction View Details'];
    final cellStyle = CellStyle(fontFamily: getFontFamily(FontFamily.Calibri));
    cellStyle.underline = Underline.Single;

    // Adding header row
    sheetObject.appendRow(
        TransactionModel.fromEntity(TransactionEntity.empty).toTextCellValueHeader());

    // Adding data rows
    for (var transaction in params) {
      var transactionModel = TransactionModel.fromEntity(transaction);
      sheetObject.appendRow(transactionModel.toTextCellValueList());
    }

    return await repository.exportToExcel(excel);
  }

  Future<Either<Failure, String>> exportToCSV(
      List<TransactionEntity> transactions) async {
    try {
      List<List<dynamic>> rows = [];

      // Add headers.
      rows.add(TransactionModel.fromEntity(TransactionEntity.empty).toCSVHeader());

      // Add data.
      for (var transaction in transactions) {
        rows.add(TransactionModel.fromEntity(transaction).toCSVList());
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
