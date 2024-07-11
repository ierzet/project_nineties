part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
  signup,
  forgotPassword,
  loading,
  partner,
}

class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.unauthenticated,
    this.user = UserAccountEntity.empty,
  });

  const AppState.authenticated(UserAccountEntity user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated()
      : this._(
          status: AppStatus.unauthenticated,
        );

  const AppState.signup()
      : this._(
          status: AppStatus.signup,
        );

  const AppState.forgotPassword()
      : this._(
          status: AppStatus.forgotPassword,
        );

  const AppState.partner()
      : this._(
          status: AppStatus.partner,
        );

  const AppState.loading()
      : this._(
          status: AppStatus.loading,
        );

  final AppStatus status;
  final UserAccountEntity user;

  @override
  List<Object> get props => [status, user];
}
