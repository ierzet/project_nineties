import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/home/data/datasources/home_remote_datasource.dart';
import 'package:project_nineties/features/home/data/model/home_model.dart';
import 'package:project_nineties/features/home/domain/entities/home_entity.dart';
import 'package:project_nineties/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required this.remoteDatasource});
  final HomeRemoteDatasource remoteDatasource;
  @override
  Future<Either<Failure, HomeEntity>> count(HomeModel initialHomeModel) async {
    final updatedMember = await remoteDatasource.countMember(initialHomeModel);
    final updatedPartner = await remoteDatasource.countPartners(updatedMember);
    final updatedUser = await remoteDatasource.countUsers(updatedPartner);
    final updateTransaction =
        await remoteDatasource.countTransactions(updatedUser);
    final result = updateTransaction.toEntity();
    return Right(result);
  }
}
