import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/member/data/models/member_model.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';

abstract class MemberRepository {
  Future<Either<Failure, String>> insertData(MemberModel params);
  Future<Either<Failure, String>> updateData(MemberModel params);
  Future<Either<Failure, List<MemberModel>>> searchMembers(
    String queryString,
    int limit,
  );
  Future<Either<Failure, List<MemberModel>>> fetchData(
      {int limit = 50, DocumentSnapshot? lastDoc});
  Stream<Either<Failure, List<MemberEntity>>> getMembersStream();
  Future<Either<Failure, String>> exportToExcel(Excel params);
  Future<Either<Failure, String>> exportToCSV(Uint8List params);
}
