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

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();

  @override
  List<Object> get props => [];
}

class AuthenticationLoaded extends AuthenticationState {
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

class AuthenticationRegistering extends AuthenticationState {
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

class AuthValidation extends AuthenticationState {
  final bool emailIsValid;
  final bool passwordIsValid;

  const AuthValidation(
      {required this.emailIsValid, required this.passwordIsValid});

  @override
  List<Object> get props => [emailIsValid, passwordIsValid];
}

class AuthValidationButton extends AuthenticationState {
  final bool emailIsValid;
  final bool passwordIsValid;

  const AuthValidationButton(
      {required this.emailIsValid, required this.passwordIsValid});

  @override
  List<Object> get props => [emailIsValid, passwordIsValid];
}

class AuthValidationResetPassword extends AuthenticationState {
  final bool emailIsValid;

  const AuthValidationResetPassword({required this.emailIsValid});

  @override
  List<Object> get props => [emailIsValid];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthValidationRegister extends AuthenticationState {
  final bool emailIsValid;
  final bool passwordIsValid;
  final bool confirmedPasswordIsValid;
  final String email;
  final String password;

  const AuthValidationRegister({
    required this.emailIsValid,
    required this.passwordIsValid,
    required this.confirmedPasswordIsValid,
    required this.email,
    required this.password,
  });
  static const isNotValid = AuthValidationRegister(
    emailIsValid: false,
    passwordIsValid: false,
    confirmedPasswordIsValid: false,
    email: '',
    password: '',
  );

  @override
  List<Object> get props =>
      [emailIsValid, passwordIsValid, confirmedPasswordIsValid];
}

class AuthResetPasswordSuccess extends AuthenticationState {
  const AuthResetPasswordSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}
