import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/user/domain/repositories/user_repository.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

class UserUseCase {
  const UserUseCase({required this.repository});

  final UserRepository repository;
  
  Future<Either<Failure, List<UserAccountEntity>>> fetchUsers() async {
    final data = await repository.fetchUsers();
    return data;
  }

  Future<Either<Failure, String>> approvalUser(UserAccountEntity params) async {
    final dataModel = UserAccountModel.fromEntity(params);
    final data = await repository.approvalUser(dataModel);
    return data;
  }

  Future<Either<Failure, String>> registerUser(UserParams params) async {
    final data = await repository.registerUser(params);
    return data;
  }

  Stream<Either<Failure, List<UserAccountEntity>>> call() {
    return repository.getUsersStream();
  }
}
