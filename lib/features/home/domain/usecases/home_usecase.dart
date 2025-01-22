import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/home/data/model/home_model.dart';
import 'package:project_nineties/features/home/domain/entities/home_entity.dart';
import 'package:project_nineties/features/home/domain/repositories/home_repository.dart';

class HomeUseCase {
  final HomeRepository repository;

  const HomeUseCase({required this.repository});
  Future<Either<Failure, HomeEntity>> count() {
    const initialHomeModel = HomeModel.empty;
    return repository.count(initialHomeModel);
  }
}
