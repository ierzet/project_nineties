part of 'partner_validator_bloc.dart';

sealed class PartnerValidatorBlocEvent extends Equatable {
  const PartnerValidatorBlocEvent();

  @override
  List<Object?> get props => [];
}

class PartnerValidatorForm extends PartnerValidatorBlocEvent {
  const PartnerValidatorForm({
    required this.partnerParams,
  });

  final PartnerParams partnerParams;
  @override
  List<Object?> get props => [partnerParams];
}

class PartnerClearValidator extends PartnerValidatorBlocEvent {
  const PartnerClearValidator({required this.context});
  final BuildContext context;
  @override
  List<Object?> get props => [context];
}
