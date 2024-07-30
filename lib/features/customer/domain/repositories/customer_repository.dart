import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/customer/data/models/customer_model.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';

abstract class CustomerRepository {
  Future<Either<Failure, String>> insertData(CustomerModel params);
  Future<Either<Failure, String>> updateData(CustomerModel params);
  Future<Either<Failure, List<CustomerModel>>> fetchData();
  Stream<Either<Failure, List<CustomerEntity>>> getCustomersStream();
  Future<Either<Failure, String>> exportToExcel(Excel params);
  Future<Either<Failure, String>> exportToCSV(Uint8List params);
}
