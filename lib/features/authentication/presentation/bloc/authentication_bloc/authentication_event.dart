part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthUserLogOut extends AuthenticationEvent {
  const AuthUserLogOut();

  @override
  List<Object> get props => [];
}

class AuthGoogleLogIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthFacebookLogin extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthEmailAndPasswordLogIn extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthEmailAndPasswordLogIn({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthUserSignUp extends AuthenticationEvent {
  final RegisterAuthentication credential;

  const AuthUserSignUp({required this.credential});

  @override
  List<Object> get props => [credential];
}

class AuthRegisterValidationChange extends AuthenticationEvent {
  final RegisterAuthentication credential;

  const AuthRegisterValidationChange(this.credential);

  @override
  List<Object> get props => [credential];
}

class AuthResetPassword extends AuthenticationEvent {
  final String email;

  const AuthResetPassword({required this.email});

  @override
  List<Object> get props => [email];
}
