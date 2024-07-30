import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/partner/data/datasources/local/partner_local_datasource.dart';
import 'package:project_nineties/features/partner/data/datasources/remote/partner_remote_datasource.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/partner/domain/repositories/pertner_repository.dart';

class PartnerRepositoryImpl implements PartnerRepository {
  final PartnerRemoteDataSource remoteDataSource;
  final PartnerLocalDataSource localDataSource;

  PartnerRepositoryImpl({
    required this.remoteDataSource,required this.localDataSource,
  });

  @override
  Stream<Either<Failure, List<PartnerEntity>>> getPartnersStream() {
    return remoteDataSource
        .getPartnersStream()
        .map<Either<Failure, List<PartnerEntity>>>(
      (partners) {
        return Right(partners);
      },
    ).handleError((error) {
      return Left(ServerFailure(error.toString()));
    });
    //TODO:rapihin handler error nya
  }

  @override
  Future<Either<Failure, String>> insertData(
    PartnerModel dataModel,
  ) async {
    try {
      // 1. Upload image
      final downloadUrl = await remoteDataSource.uploadImage(dataModel);
      dataModel = dataModel.copyWith(partnerImageUrl: downloadUrl);

      // 2. insert partner dataModel to firestrore
      final result = await remoteDataSource.insertData(dataModel);

      //3. mengembalikan  nilai string
      return Right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updateData(PartnerModel dataModel) async {
    try {
      // 1. Upload image
      final downloadUrl = await remoteDataSource.uploadImage(dataModel);
      dataModel = dataModel.copyWith(partnerImageUrl: downloadUrl);

      // 2. insert partner dataModel to firestrore
      final result = await remoteDataSource.updateData(dataModel);

      //3. mengembalikan  nilai string
      return Right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PartnerModel>>> fetchData() async {
    try {
      final queryData = await remoteDataSource.fetchData();
      final result =
          queryData.docs.map((doc) => PartnerModel.fromFirestore(doc)).toList();
      return Right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> exportToExcel(Excel params) async {
    try {
      final result = await localDataSource.exportToExcel(params);
      return Right(result);
    } catch (e) {
      return Left(ExportToExcel(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> exportToCSV(Uint8List params) async {
    try {
      final result = await localDataSource.exportToCSV(params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
