import 'package:equatable/equatable.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class UserAccountEntity extends Equatable {
  final String userId;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final DateTime? joinDate;
  final String? photo;
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
    required this.userId,
    this.email,
    this.name,
    this.phoneNumber,
    this.joinDate,
    this.photo,
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
    String? userId,
    String? email,
    String? name,
    String? phoneNumber,
    DateTime? joinDate,
    String? photo,
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
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      joinDate: joinDate ?? this.joinDate,
      photo: photo ?? this.photo,
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
      UserAccountEntity(userId: '', partner: PartnerEntity.empty);

  bool get isEmpty => this == UserAccountEntity.empty;
  bool get isNotEmpty => this != UserAccountEntity.empty;

  @override
  List<Object?> get props => [
        userId,
        email,
        name,
        phoneNumber,
        photo,
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
