import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/member/data/datasources/local/member_local_datasource.dart';
import 'package:project_nineties/features/member/data/datasources/remote/member_remote_datasource.dart';
import 'package:project_nineties/features/member/data/models/member_model.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/member/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  const MemberRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final MemberRemoteDataSource remoteDataSource;
  final MemberLocalDataSource localDataSource;

  @override
  Stream<Either<Failure, List<MemberEntity>>> getMembersStream() {
    return remoteDataSource
        .getMembersStream()
        .map<Either<Failure, List<MemberEntity>>>(
      (members) {
        return Right(members);
      },
    ).handleError((error) {
      return Left(ServerFailure(error.toString()));
    });
    //TODO:rapihin handler error nya
  }

  @override
  Future<Either<Failure, String>> updateData(MemberModel dataModel) async {
    try {
      // print('dataModel url: ${dataModel.memberJoinPartner}');
      if (dataModel.memberPhotoOfVehicleFile != null) {
        final downloadUrl = await remoteDataSource.uploadImage(dataModel);
        dataModel = dataModel.copyWith(memberPhotoOfVehicle: downloadUrl);
      }
      // print('dataModel : ${dataModel.memberJoinPartner}');
      final result = await remoteDataSource.updateData(dataModel);

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
  Future<Either<Failure, List<MemberModel>>> fetchData(
      {int limit = 50, DocumentSnapshot? lastDoc}) async {
    try {
      final queryData =
          await remoteDataSource.fetchData(limit: limit, lastDoc: lastDoc);
      final result =
          queryData.docs.map((doc) => MemberModel.fromFirestore(doc)).toList();
      return Right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(FireBaseCatchFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MemberModel>>> searchMembers(
    String queryString,
    int limit,
  ) async {
    try {
      final queryData =
          await remoteDataSource.searchMembers(queryString, limit);
      final result =
          queryData.docs.map((doc) => MemberModel.fromFirestore(doc)).toList();
      return Right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(FireBaseCatchFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> insertData(MemberModel params) async {
    try {
      // 1. Upload image
      //print('params url: ${params.memberJoinPartner}');
      if (params.memberPhotoOfVehicleFile != null) {
        final downloadUrl = await remoteDataSource.uploadImage(params);
        params = params.copyWith(memberPhotoOfVehicle: downloadUrl);
      }
      //print('params repo: ${params.memberJoinPartner}');
      // 2. insert partner dataModel to firestrore
      final result = await remoteDataSource.insertData(params);
      return Right(result);
    } on FireBaseCatchFailure catch (e) {
      return Left(
        FireBaseCatchFailure(e.message),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
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
