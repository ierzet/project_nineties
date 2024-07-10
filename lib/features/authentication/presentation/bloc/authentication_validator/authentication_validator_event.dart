part of 'authentication_validator_bloc.dart';

sealed class AuthenticationValidatorEvent extends Equatable {
  const AuthenticationValidatorEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationValidatorForm extends AuthenticationValidatorEvent {
  const AuthenticationValidatorForm({required this.params});
  final AuthenticationParams params;
  @override
  List<Object> get props => [params];
}

class AuthenticationClearValidator extends AuthenticationValidatorEvent {
  const AuthenticationClearValidator();

  @override
  List<Object> get props => [];
}
