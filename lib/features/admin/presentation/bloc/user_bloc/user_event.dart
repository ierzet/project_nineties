part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGetData extends UserEvent {
  const UserGetData();

  @override
  List<Object> get props => [];
}

class UserUpdateData extends UserEvent {
  const UserUpdateData({
    required this.context,
    required this.updatedUser,
    required this.userAccountEntity,
  });

  final BuildContext context;
  final UserAccountEntity userAccountEntity;
  final String updatedUser;
  @override
  List<Object> get props => [context, userAccountEntity, updatedUser];
}
