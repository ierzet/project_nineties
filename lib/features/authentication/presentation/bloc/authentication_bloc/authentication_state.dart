part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();

  @override
  List<Object> get props => [];
}

final class AuthenticationInit extends AuthenticationState {
  const AuthenticationInit();

  @override
  List<Object> get props => [];
}

final class AuthenticationLoaded extends AuthenticationState {
  final AuthenticationStatus status;
  final UserDynamic user;
  const AuthenticationLoaded._({
    required this.status,
    this.user = UserDynamic.empty,
  });

  const AuthenticationLoaded.authenticated(UserDynamic user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationLoaded.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}

final class AuthenticationRegistering extends AuthenticationState {
  const AuthenticationRegistering();

  @override
  List<Object> get props => [];
}

class AuthenticationRegistered extends AuthenticationState {
  final String result;
  const AuthenticationRegistered(this.result);
  @override
  List<Object> get props => [result];
}

final class AuthValidation extends AuthenticationState {
  final bool emailIsValid;
  final bool passwordIsValid;

  const AuthValidation(
      {required this.emailIsValid, required this.passwordIsValid});

  @override
  List<Object> get props => [emailIsValid, passwordIsValid];
}

final class AuthValidationButton extends AuthenticationState {
  final bool emailIsValid;
  final bool passwordIsValid;

  const AuthValidationButton(
      {required this.emailIsValid, required this.passwordIsValid});

  @override
  List<Object> get props => [emailIsValid, passwordIsValid];
}

final class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthValidationRegister extends AuthenticationState {
  final bool emailIsValid;
  final bool passwordIsValid;
  final bool confirmedPasswordIsValid;

  const AuthValidationRegister(
      {required this.emailIsValid,
      required this.passwordIsValid,
      required this.confirmedPasswordIsValid});

  @override
  List<Object> get props =>
      [emailIsValid, passwordIsValid, confirmedPasswordIsValid];
}
