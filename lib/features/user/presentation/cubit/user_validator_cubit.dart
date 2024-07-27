import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class UserValidatorCubit extends Cubit<UserAccountEntity> {
  UserValidatorCubit() : super(UserAccountEntity.empty);

  void clearValidation() {
    emit(UserAccountEntity.empty);
  }

  void updateUser({
    required UserAccountEntity userAccountenitity,
  }) {
    emit(userAccountenitity);
  }

  void updateRole({
    required String? role,
  }) {
    emit(
      state.copyWith(roleId: role),
    );
  }

  void updatePartner({
    required PartnerEntity partner,
  }) {
    emit(
      state.copyWith(partner: partner),
    );
  }
}
