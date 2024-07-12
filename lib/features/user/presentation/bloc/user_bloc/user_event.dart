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

class UserApproval extends UserEvent {
  const UserApproval({
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

class UserRegisterByAdmin extends UserEvent {
  const UserRegisterByAdmin({required this.params});

  final UserParams params;
  @override
  List<Object> get props => [params];
}

class UserSubscriptionSuccess extends UserEvent {
  const UserSubscriptionSuccess({required this.params});

  final List<UserAccountEntity> params;
  @override
  List<Object> get props => [params];
}

class UserSubscriptionFailure extends UserEvent {
  const UserSubscriptionFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}
