part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, signup }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = UserAccountEntity.empty,
  });
  const AppState.authenticated(UserAccountEntity user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.signup() : this._(status: AppStatus.signup); // Add this line

  final AppStatus status;
  final UserAccountEntity user;
  @override
  List<Object?> get props => [status, user];
}
