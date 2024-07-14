import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/customer/data/models/customer_model.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/customer/domain/repositories/customer_repository.dart';

class CustomerUseCase {
  const CustomerUseCase({required this.repository});

  final CustomerRepository repository;

  Future<Either<Failure, String>> insertData(CustomerEntity params) async {
    final paramModel = CustomerModel.fromEntity(params);
    final result = await repository.insertData(paramModel);
    return result;
    //return Right(params.toString());
  }

  Future<Either<Failure, String>> updateData(CustomerEntity params) async {
    final dataModel = CustomerModel.fromEntity(params);
    return repository.updateData(dataModel);
  }

  Future<Either<Failure, List<CustomerEntity>>> fetchData() async {
    final listModelResult = await repository.fetchData();
    final listEnity = listModelResult
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEnity;
  }

  Stream<Either<Failure, List<CustomerEntity>>> call() {
    return repository.getCustomersStream();
  }
}
