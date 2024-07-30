import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

abstract class PartnerRepository {
  Future<Either<Failure, String>> insertData(PartnerModel dataModel);
  Future<Either<Failure, String>> updateData(PartnerModel dataModel);
  Future<Either<Failure, List<PartnerModel>>> fetchData();
  Stream<Either<Failure, List<PartnerEntity>>> getPartnersStream();
  Future<Either<Failure, String>> exportToExcel(Excel params);
  Future<Either<Failure, String>> exportToCSV(Uint8List params);
}
