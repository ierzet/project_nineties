import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/partner/domain/repositories/pertner_repository.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';

class PartnerUseCase {
  const PartnerUseCase({required this.repository});

  final PartnerRepository repository;

  Future<Either<Failure, String>> insertData(PartnerParams params) async {
    final dataModel = PartnerModel.fromParams(params);
    return repository.insertData(dataModel);
  }

  Future<Either<Failure, String>> updateData(PartnerParams params) async {
    final dataModel = PartnerModel.fromParams(params);
    return repository.updateData(dataModel);
  }

  Future<Either<Failure, List<PartnerEntity>>> fetchData() async {
    final listModelResult = await repository.fetchData();
    final listEnity = listModelResult
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEnity;
  }

  Stream<Either<Failure, List<PartnerEntity>>> call() {
    return repository.getPartnersStream();
  }

  Future<Either<Failure, String>> exportToExcel(
      List<PartnerEntity> params) async {
    // Create a new Excel document
    final excel = Excel.createExcel();
    final sheetObject = excel['Partner View Details'];
    final cellStyle = CellStyle(fontFamily: getFontFamily(FontFamily.Calibri));
    cellStyle.underline = Underline.Single;

    // Adding header row
    sheetObject.appendRow(
        PartnerModel.fromEntity(PartnerEntity.empty).toTextCellValueHeader());

    // Adding data rows
    for (var partner in params) {
      var partnerModel = PartnerModel.fromEntity(partner);
      sheetObject.appendRow(partnerModel.toTextCellValueList());
    }

    return await repository.exportToExcel(excel);
  }

  Future<Either<Failure, String>> exportToCSV(
      List<PartnerEntity> partners) async {
    try {
      List<List<dynamic>> rows = [];

      // Add headers.
      rows.add(PartnerModel.fromEntity(PartnerEntity.empty).toCSVHeader());

      // Add data.
      for (var partner in partners) {
        rows.add(PartnerModel.fromEntity(partner).toCSVList());
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
