import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_params.dart';

part 'authentication_validator_event.dart';
part 'authentication_validator_state.dart';

class AuthenticationValidatorBloc
    extends Bloc<AuthenticationValidatorEvent, AuthenticationValidatorState> {
  AuthenticationValidatorBloc() : super(AuthenticationValidatorState.empty) {
    on<AuthenticationValidatorForm>(_onAuthenticationValidatorForm);
    on<AuthenticationClearValidator>(_onAuthenticationClearValidator);
  }
  void _onAuthenticationValidatorForm(AuthenticationValidatorForm event,
      Emitter<AuthenticationValidatorState> emit) async {
    //print('event: ${event.partnerParams}');

    emit(AuthenticationValidatorState(params: event.params));
  }

  void _onAuthenticationClearValidator(AuthenticationClearValidator event,
      Emitter<AuthenticationValidatorState> emit) async {
    //print('event: ${event.partnerParams}');
    emit(AuthenticationValidatorState.empty);
  }
}
