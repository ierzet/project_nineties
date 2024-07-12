part of 'user_validator_bloc.dart';

sealed class UserValidatorEvent extends Equatable {
  const UserValidatorEvent();

  @override
  List<Object> get props => [];
}

class UserValidatorForm extends UserValidatorEvent {
  const UserValidatorForm({required this.params});
  final UserParams params;
  @override
  List<Object> get props => [params];
}

class UserClearValidator extends UserValidatorEvent {
  const UserClearValidator();

  @override
  List<Object> get props => [];
}
