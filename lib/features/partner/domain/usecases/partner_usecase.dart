import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/partner/domain/repositories/pertner_repository.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';

class PartnerUseCase {
  const PartnerUseCase({required this.repository});

  final PartnerRepository repository;

  Future<Either<Failure, String>> insertData(PartnerParams params) async {
    final dataModel = PartnerModel.fromParams(params);
    return repository.insertData(dataModel);
  }

  Future<Either<Failure, String>> updateData(PartnerParams params) async {
    final dataModel = PartnerModel.fromParams(params);
    return repository.updateData(dataModel);
  }

  Future<Either<Failure, List<PartnerEntity>>> fetchPartners() async {
    final listModelResulut = await repository.fetchPartners();
    final listEnity = listModelResulut
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEnity;
  }

  Stream<Either<Failure, List<PartnerEntity>>> call() {
    return repository.getPartnersStream();
  }
}
