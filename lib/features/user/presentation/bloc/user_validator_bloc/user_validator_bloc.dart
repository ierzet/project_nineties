import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';

part 'user_validator_event.dart';
part 'user_validator_state.dart';

class UserValidatorBloc extends Bloc<UserValidatorEvent, UserValidatorState> {
  UserValidatorBloc() : super(UserValidatorState.empty) {
    on<UserValidatorForm>(_onUserValidatorForm);
    on<UserClearValidator>(_onUserClearValidator);
  }
  void _onUserValidatorForm(
      UserValidatorForm event, Emitter<UserValidatorState> emit) async {
    //print('event: ${event.partnerParams}');

    emit(UserValidatorState(params: event.params));
  }

  void _onUserClearValidator(
      UserClearValidator event, Emitter<UserValidatorState> emit) async {
    //print('event: ${event.partnerParams}');
    emit(UserValidatorState.empty);
  }
}
