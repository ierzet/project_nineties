import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/customer/data/models/customer_model.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/customer/domain/repositories/customer_repository.dart';

class CustomerUseCase {
  const CustomerUseCase({required this.repository});

  final CustomerRepository repository;

  Future<Either<Failure, String>> insertData(CustomerEntity params) async {
    final paramModel = CustomerModel.fromEntity(params);
    final result = await repository.insertData(paramModel);
    return result;
    //return Right(params.toString());
  }

  Future<Either<Failure, String>> updateData(CustomerEntity params) async {
    final dataModel = CustomerModel.fromEntity(params);
    return repository.updateData(dataModel);
  }

  Future<Either<Failure, List<CustomerEntity>>> fetchData() async {
    final listModelResult = await repository.fetchData();
    final listEnity = listModelResult
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEnity;
  }

  Stream<Either<Failure, List<CustomerEntity>>> call() {
    return repository.getCustomersStream();
  }

  Future<Either<Failure, String>> exportToExcel(
      List<CustomerEntity> params) async {
    // Create a new Excel document
    final excel = Excel.createExcel();
    final sheetObject = excel['Customer View Details'];
    final cellStyle = CellStyle(fontFamily: getFontFamily(FontFamily.Calibri));
    cellStyle.underline = Underline.Single;

    // Adding header row
    sheetObject.appendRow(
        CustomerModel.fromEntity(CustomerEntity.empty).toTextCellValueHeader());

    // Adding data rows
    for (var customer in params) {
      var customerModel = CustomerModel.fromEntity(customer);
      sheetObject.appendRow(customerModel.toTextCellValueList());
    }

    return await repository.exportToExcel(excel);
  }

  Future<Either<Failure, String>> exportToCSV(
      List<CustomerEntity> customers) async {
    try {
      List<List<dynamic>> rows = [];

      // Add headers.
      rows.add(CustomerModel.fromEntity(CustomerEntity.empty).toCSVHeader());

      // Add data.
      for (var customer in customers) {
        rows.add(CustomerModel.fromEntity(customer).toCSVList());
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
