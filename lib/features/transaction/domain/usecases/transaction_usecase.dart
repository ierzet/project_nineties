import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/transaction/data/models/transaction_model.dart';
import 'package:project_nineties/features/transaction/domain/entities/transaction_entity.dart';
import 'package:project_nineties/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionUseCase {
  const TransactionUseCase({required this.repository});
  final TransactionRepository repository;

  Stream<Either<Failure, List<TransactionEntity>>> call() {
    return repository.getTransactionsStream();
  }

  Future<Either<Failure, CustomerEntity>> getCustomer(String param) async {
    final result = repository.getCustomer(param);
    return result;
  }

  Future<Either<Failure, List<TransactionEntity>>> fetchData() async {
    final listModelResult = await repository.fetchData();
    final listEnity = listModelResult
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEnity;
  }

  Future<Either<Failure, String>> addTransaction(
      {required CustomerEntity customerEntity,
      required UserAccountEntity userAccountEntity}) async {
    final paramModel = TransactionModel.empty.copyWith(
      user: userAccountEntity.user,
      partner: userAccountEntity.partner,
      customer: customerEntity,
      transactionDate: DateTime.now(),
      createdBy: userAccountEntity.user.id,
      createdDate: DateTime.now(),
    );
    final result = repository.addTransaction(paramModel);
    return result;
  }
}
