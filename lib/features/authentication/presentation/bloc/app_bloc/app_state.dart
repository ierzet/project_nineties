part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, signup, forgotPassword }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = UserEntity.empty,
  });
  const AppState.authenticated(UserEntity user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.signup() : this._(status: AppStatus.signup); // Add this line
  const AppState.forgotPassword()
      : this._(status: AppStatus.forgotPassword); // Add this line

  final AppStatus status;
  final UserEntity user;
  @override
  List<Object?> get props => [status, user];
}
