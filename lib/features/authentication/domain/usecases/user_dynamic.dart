import 'package:equatable/equatable.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';

class UserDynamic extends Equatable {
  final UserEntity userEntity;
  final UserAccountEntity userAccountEntity;

  const UserDynamic(
      {required this.userEntity, required this.userAccountEntity});
  static const empty = UserDynamic(
    userEntity: UserEntity.empty,
    userAccountEntity: UserAccountEntity.empty,
  );
  bool get isEmpty => this == UserDynamic.empty;

  bool get isNotEmpty => this != UserDynamic.empty;

  @override
  List<Object?> get props => [userEntity, userAccountEntity];
}
