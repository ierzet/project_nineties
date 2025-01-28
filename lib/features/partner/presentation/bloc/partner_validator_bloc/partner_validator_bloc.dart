import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';

part 'partner_validator_bloc_state.dart';
part 'partner_validator_bloc_event.dart';

class PartnerValidatorBloc
    extends Bloc<PartnerValidatorBlocEvent, PartnerValidatorBlocState> {
  PartnerValidatorBloc() : super(PartnerValidatorBlocState.empty) {
    on<PartnerValidatorForm>(_onPartnerValidatorForm);
    on<PartnerClearValidator>(_onPartnerClearValidator);
  }
  void _onPartnerValidatorForm(PartnerValidatorForm event,
      Emitter<PartnerValidatorBlocState> emit) async {
    emit(PartnerValidatorBlocState(partnerParams: event.partnerParams));
  }

  void _onPartnerClearValidator(PartnerClearValidator event,
      Emitter<PartnerValidatorBlocState> emit) async {
    emit(PartnerValidatorBlocState.empty);
  }
}
