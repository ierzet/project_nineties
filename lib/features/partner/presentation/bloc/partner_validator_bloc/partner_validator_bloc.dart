import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';

part 'partner_validator_bloc_state.dart';
part 'partner_validator_bloc_event.dart';

class PartnerValidatorBloc
    extends Bloc<PartnerValidatorBlocEvent, PartnerValidatorBlocState> {
  PartnerValidatorBloc() : super(PartnerValidatorBlocState.empty) {
    on<PartnerValidatorBlocEvent>(_onPartnerValidatorBlocEvent);
  }
  void _onPartnerValidatorBlocEvent(PartnerValidatorBlocEvent event,
      Emitter<PartnerValidatorBlocState> emit) async {
    //print('event: ${event.partnerParams}');

    emit(PartnerValidatorBlocState(partnerParams: event.partnerParams));
  }
}
