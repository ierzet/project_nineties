import 'package:equatable/equatable.dart';
import 'package:project_nineties/features/user/domain/entities/user_entity.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class UserAccountEntity extends Equatable {
  final UserEntity user;
  final DateTime? joinDate;
  final bool? isActive;
  final PartnerEntity partner;
  final String? roleId;
  final List<String>? menuAuth;
  final bool? isInitiate;
  final String? createdBy;
  final DateTime? createdDate;
  final String? updatedBy;
  final DateTime? updatedDate;
  final String? deletedBy;
  final DateTime? deletedDate;
  final bool? isDeleted;

  const UserAccountEntity({
    required this.user,
    this.joinDate,
    this.isActive,
    required this.partner,
    this.roleId,
    this.menuAuth,
    this.isInitiate,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.deletedBy,
    this.deletedDate,
    this.isDeleted,
  });

  UserAccountEntity copyWith({
    UserEntity? user,
    DateTime? joinDate,
    bool? isActive,
    PartnerEntity? partner,
    String? roleId,
    List<String>? menuAuth,
    bool? isInitiate,
    String? createdBy,
    DateTime? createdDate,
    String? updatedBy,
    DateTime? updatedDate,
    String? deletedBy,
    DateTime? deletedDate,
    bool? isDeleted,
  }) {
    return UserAccountEntity(
      user: user ?? this.user,
      joinDate: joinDate ?? this.joinDate,
      isActive: isActive ?? this.isActive,
      partner: partner ?? this.partner,
      roleId: roleId ?? this.roleId,
      menuAuth: menuAuth ?? this.menuAuth,
      isInitiate: isInitiate ?? this.isInitiate,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedDate: deletedDate ?? this.deletedDate,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  static const empty =
      UserAccountEntity(user: UserEntity.empty, partner: PartnerEntity.empty);

  bool get isEmpty => this == UserAccountEntity.empty;
  bool get isNotEmpty => this != UserAccountEntity.empty;

  @override
  List<Object?> get props => [
        user,
        joinDate,
        isActive,
        partner,
        roleId,
        menuAuth,
        isInitiate,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate,
        isDeleted,
      ];
}
