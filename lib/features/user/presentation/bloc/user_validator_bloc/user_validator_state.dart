part of 'user_validator_bloc.dart';

class UserValidatorState extends Equatable {
  const UserValidatorState({
    required this.params,
  });
  final UserParams params;

  static const empty = UserValidatorState(params: UserParams.empty);

  bool get isEmpty => this == UserValidatorState.empty;
  bool get isNotEmpty => this != UserValidatorState.empty;

  @override
  List<Object?> get props => [params];
}
