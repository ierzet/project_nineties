import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/member/data/models/member_model.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/member/domain/repositories/member_repository.dart';

class MemberUseCase {
  const MemberUseCase({required this.repository});

  final MemberRepository repository;

  Future<Either<Failure, String>> insertData(MemberEntity params) async {
    //print('params usecase: ${params.memberJoinPartner}');
    final paramModel = MemberModel.fromEntity(params);
    //print('paramModel : ${paramModel.memberJoinPartner}');
    final result = await repository.insertData(paramModel);
    return result;
    //return Right(params.toString());
  }

  Future<Either<Failure, String>> updateData(MemberEntity params) async {
    // print('params usecase: ${params.memberJoinPartner}');
    final dataModel = MemberModel.fromEntity(params);
    // print('paramModel : ${dataModel.memberJoinPartner}');
    return repository.updateData(dataModel);
  }

  Future<Either<Failure, List<MemberEntity>>> fetchData(
      {int limit = 50, DocumentSnapshot? lastDoc}) async {
    final listModelResult =
        await repository.fetchData(limit: limit, lastDoc: lastDoc);
    final listEntity = listModelResult
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEntity;
  }

  Future<Either<Failure, List<MemberEntity>>> searchMembers(
    String queryString,
    int limit,
  ) async {
    final listModelResult = await repository.searchMembers(queryString, limit);
    final listEntity = listModelResult
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEntity;
  }

  Stream<Either<Failure, List<MemberEntity>>> call() {
    return repository.getMembersStream();
  }

  Future<Either<Failure, String>> exportToExcel(
      List<MemberEntity> params) async {
    // Create a new Excel document
    final excel = Excel.createExcel();
    final sheetObject = excel['Member View Details'];
    final cellStyle = CellStyle(fontFamily: getFontFamily(FontFamily.Calibri));
    cellStyle.underline = Underline.Single;

    // Adding header row
    sheetObject.appendRow(
        MemberModel.fromEntity(MemberEntity.empty).toTextCellValueHeader());

    // Adding data rows
    for (var member in params) {
      var memberModel = MemberModel.fromEntity(member);
      sheetObject.appendRow(memberModel.toTextCellValueList());
    }

    return await repository.exportToExcel(excel);
  }

  Future<Either<Failure, String>> exportToCSV(
      List<MemberEntity> members) async {
    try {
      List<List<dynamic>> rows = [];

      // Add headers.
      rows.add(MemberModel.fromEntity(MemberEntity.empty).toCSVHeader());

      // Add data.
      for (var member in members) {
        rows.add(MemberModel.fromEntity(member).toCSVList());
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
