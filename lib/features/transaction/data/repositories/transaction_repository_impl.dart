import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/transaction/data/datasources/local/transaction_local_datasource.dart';
import 'package:project_nineties/features/transaction/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:project_nineties/features/transaction/data/models/transaction_model.dart';
import 'package:project_nineties/features/transaction/domain/entities/transaction_entity.dart';
import 'package:project_nineties/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;

  @override
  Stream<Either<Failure, List<TransactionEntity>>> getTransactionsStream() {
    return remoteDataSource
        .getTransactionsStream()
        .map<Either<Failure, List<TransactionEntity>>>(
      (transactions) {
        return Right(transactions);
      },
    ).handleError((error) {
      return Left(ServerFailure(error.toString()));
    });
    //TODO:rapihin handler error nya
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> fetchData() async {
    try {
      final queryData = await remoteDataSource.fetchData();

      final result = queryData.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();

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
  Future<Either<Failure, MemberEntity>> getMember(String param) async {
    try {
      final resultModel = await remoteDataSource.getMember(param);
      final result = resultModel.toEntity();
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
  Future<Either<Failure, String>> addTransaction(
      TransactionModel params) async {
    try {
      final result = await remoteDataSource.addTransaction(params);
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
