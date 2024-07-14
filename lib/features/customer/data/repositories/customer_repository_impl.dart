import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:project_nineties/features/customer/data/models/customer_model.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/customer/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  const CustomerRepositoryImpl({required this.remoteDataSource});

  final CustomerRemoteDataSource remoteDataSource;

  @override
  Stream<Either<Failure, List<CustomerEntity>>> getCustomersStream() {
    return remoteDataSource
        .getCustomersStream()
        .map<Either<Failure, List<CustomerEntity>>>(
      (cutomers) {
        return Right(cutomers);
      },
    ).handleError((error) {
      return Left(ServerFailure(error.toString()));
    });
    //TODO:rapihin handler error nya
  }

  @override
  Future<Either<Failure, String>> updateData(CustomerModel dataModel) async {
    try {
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
  Future<Either<Failure, List<CustomerModel>>> fetchData() async {
    try {
      final queryData = await remoteDataSource.fetchData();
      final result = queryData.docs
          .map((doc) => CustomerModel.fromFirestore(doc))
          .toList();
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
  Future<Either<Failure, String>> insertData(CustomerModel params) async {
    try {
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
}
