part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {
  const UserLoadInProgress();
  @override
  List<Object> get props => [];
}

class UserLoadSuccess extends UserState {
  const UserLoadSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [];
}

class UserLoadDataSuccess extends UserState {
  const UserLoadDataSuccess({required this.data});

  final List<UserAccountEntity> data;
  @override
  List<Object> get props => [data];
}

class UserLoadApprovalSuccess extends UserState {
  const UserLoadApprovalSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class UserLoadRegisterSuccess extends UserState {
  const UserLoadRegisterSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class UserLoadFailure extends UserState {
  const UserLoadFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}
