part of 'authentication_validator_bloc.dart';

class AuthenticationValidatorState extends Equatable {
  const AuthenticationValidatorState({
    required this.params,
  });
  final AuthenticationParams params;

  static const empty =
      AuthenticationValidatorState(params: AuthenticationParams.empty);

  bool get isEmpty => this == AuthenticationValidatorState.empty;
  bool get isNotEmpty => this != AuthenticationValidatorState.empty;

  @override
  List<Object?> get props => [params];
}
