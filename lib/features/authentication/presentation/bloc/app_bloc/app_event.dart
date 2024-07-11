part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final UserAccountEntity user;

  @override
  List<Object> get props => [user];
}

class NavigateToSignup extends AppEvent {
  const NavigateToSignup();

  @override
  List<Object> get props => [];
}

class NavigateToForgotPassword extends AppEvent {
  const NavigateToForgotPassword();

  @override
  List<Object> get props => [];
}
