part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = UserAccountEntity.empty,
  });
  const AppState.authenticated(UserAccountEntity user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  final AppStatus status;
  final UserAccountEntity user;
  @override
  List<Object?> get props => [];
}
