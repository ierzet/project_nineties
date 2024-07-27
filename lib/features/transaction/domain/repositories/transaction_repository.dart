
import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/transaction/data/models/transaction_model.dart';
import 'package:project_nineties/features/transaction/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, CustomerEntity>> getCustomer(String param);
  Future<Either<Failure, String>> addTransaction(TransactionModel param);
  Future<Either<Failure, List<TransactionModel>>> fetchData();
  Stream<Either<Failure, List<TransactionEntity>>> getTransactionsStream();
}
