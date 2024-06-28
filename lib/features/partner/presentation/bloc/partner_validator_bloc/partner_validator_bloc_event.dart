part of 'partner_validator_bloc.dart';

class PartnerValidatorBlocEvent extends Equatable {
  const PartnerValidatorBlocEvent({
    required this.partnerParams,
  });
  final PartnerParams partnerParams;
  @override
  List<Object?> get props => [partnerParams];
}
