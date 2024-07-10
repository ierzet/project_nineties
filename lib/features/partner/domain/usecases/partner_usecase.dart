import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/partner/domain/repositories/pertner_repository.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';

class PartnerUseCase {
  final PartnerRepository repository;

  const PartnerUseCase({required this.repository});

  Future<Either<Failure, String>> insertData(PartnerParams params) async {
    final dataModel = PartnerModel.fromParams(params);
    return repository.insertData(dataModel);
  }

  Future<Either<Failure, List<PartnerEntity>>> fetchPartners() async {
    final listModelResulut = await repository.fetchPartners();
    final listEnity = listModelResulut
        .map((models) => models.map((model) => model.toEntity()).toList());

    return listEnity;
  }
}
