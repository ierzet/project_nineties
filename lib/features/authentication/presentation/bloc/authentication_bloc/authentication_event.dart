part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthenticationEvent {
  const AuthUserChanged();

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

class AuthValidationChange extends AuthenticationEvent {
  final LoginAuthentication credential;

  const AuthValidationChange(this.credential);

  @override
  List<Object> get props => [credential];
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
  final File? imageData;

  const AuthUserSignUp(this.credential, this.imageData);

  @override
  List<Object> get props => [credential];
}

class AuthRegisterValidationChange extends AuthenticationEvent {
  final RegisterAuthentication credential;

  const AuthRegisterValidationChange(this.credential);

  @override
  List<Object> get props => [credential];
}
