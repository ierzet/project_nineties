import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/authentication/data/models/user_model.dart';

class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    required super.user,
    super.joinDate,
    super.isActive,
    required super.partner,
    super.roleId,
    super.menuAuth,
    super.isInitiate,
    super.createdBy,
    super.createdDate,
    super.updatedBy,
    super.updatedDate,
    super.deletedBy,
    super.deletedDate,
    super.isDeleted,
  });

  UserAccountEntity toEntity() => UserAccountEntity(
        user: user,
        joinDate: joinDate,
        isActive: isActive,
        partner: partner,
        roleId: roleId,
        menuAuth: menuAuth,
        isInitiate: isInitiate,
        createdBy: createdBy,
        createdDate: createdDate,
        updatedBy: updatedBy,
        updatedDate: updatedDate,
        deletedBy: deletedBy,
        deletedDate: deletedDate,
        isDeleted: isDeleted,
      );

  factory UserAccountModel.fromEntity(UserAccountEntity entity) {
    return UserAccountModel(
      user: entity.user,
      joinDate: entity.joinDate,
      isActive: entity.isActive,
      partner: entity.partner,
      roleId: entity.roleId,
      menuAuth: entity.menuAuth,
      isInitiate: entity.isInitiate,
      createdBy: entity.createdBy,
      createdDate: entity.createdDate,
      updatedBy: entity.updatedBy,
      updatedDate: entity.updatedDate,
      deletedBy: entity.deletedBy,
      deletedDate: entity.deletedDate,
      isDeleted: entity.isDeleted,
    );
  }

  factory UserAccountModel.fromFirebaseUser(User firebaseUser) {
    try {
      return UserAccountModel(
        user: UserModel.fromFirebaseUser(firebaseUser).toEntity(),
        partner: PartnerEntity.empty,
      );
    } on Exception catch (e) {
      debugPrint('Error in UserAccountModel.fromFirebaseUser: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'user': UserModel.fromEntity(user).toJson(),
        'join_date':
            joinDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'is_active': isActive ?? false,
        'partner': PartnerModel.fromEntity(partner).toJson(),
        'role_id': roleId,
        'menu_auth': menuAuth,
        'is_initiate': isInitiate ?? false,
        'created_by': user.id,
        'created_date':
            createdDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'updated_by': updatedBy,
        'updated_date': updatedDate?.toIso8601String(),
        'deleted_by': deletedBy,
        'deleted_date': deletedDate?.toIso8601String(),
        'is_deleted': isDeleted ?? false,
      };
    } on Exception catch (e) {
      debugPrint('Error in UserAccountModel.toJson: $e');
      rethrow;
    }
  }

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserAccountModel(
        user: UserModel.fromJson(json).toEntity(),
        joinDate: (json['join_date'] as Timestamp?)?.toDate(),
        isActive: json['is_active'] ?? false,
        partner: PartnerModel.fromJson(json).toEntity(),
        roleId: json['role_id'] ?? '',
        menuAuth: json['menu_auth'] ?? [],
        isInitiate: json['is_initiate'],
        createdBy: json['created_by'],
        createdDate: json['created_date'],
        updatedBy: json['updated_by'],
        updatedDate: json['updated_date'],
        deletedBy: json['deleted_by'],
        deletedDate: json['deleted_date'],
        isDeleted: json['is_deleted'],
      );
    } on Exception catch (e) {
      debugPrint('Error in UserAccountModel.fromJson: $e');
      rethrow;
    }
  }
  factory UserAccountModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    try {
      return UserAccountModel(
        user: UserModel.fromFirestore(snapshot).toEntity(),
        joinDate: (data['join_date'] as Timestamp?)?.toDate(),
        isActive: data['is_active'] ?? false,
        partner: data['partner'] != null
            ? PartnerModel.fromJson(Map<String, dynamic>.from(data['partner']))
                .toEntity()
            : PartnerEntity.empty,
        // partner: PartnerModel.fromFirestoreUserAccount(snapshot).toEntity(),
        roleId: data['role_id'],
        menuAuth: List<String>.from(data['menu_auth'] ?? []),
        isInitiate: data['is_initiate'] ?? false,
        createdBy: data['created_by'],
        createdDate: (data['created_date'] as Timestamp?)?.toDate(),
        updatedBy: data['updated_by'] ?? '',
        updatedDate: (data['updated_date'] as Timestamp?)?.toDate(),
        deletedBy: data['deleted_by'] ?? '',
        deletedDate: (data['deleted_date'] as Timestamp?)?.toDate(),
        isDeleted: data['is_deleted'] ?? false,
      );
    } catch (e) {
      debugPrint('Error in UserAccountModel.fromFirestore: $e');
      rethrow;
    }
  }

  Map<String, dynamic> initiateUserAccountToFirestore(
      bool newIsIntitiate, String uid) {
    try {
      return {
        'user': UserModel.fromEntity(user).toFirestore(),
        'join_date':
            joinDate != null ? Timestamp.fromDate(joinDate!) : DateTime.now(),
        'is_active': isActive ?? false,
        //newIsIntitiate true, maka data partner pasti masih kosong karena belum di appove
        'partner': PartnerModel.fromEntity(partner).toFireStore(),
        'role_id': roleId,
        'menu_auth': menuAuth,
        'is_initiate': newIsIntitiate,
        'created_by': uid,
        'created_date': createdDate != null
            ? Timestamp.fromDate(joinDate!)
            : DateTime.now(),
        'updated_by': updatedBy,
        'updated_date': updatedDate,
        'deleted_by': deletedBy,
        'deleted_date': deletedDate,
        'is_deleted': isDeleted ?? false,
      };
    } catch (e) {
      debugPrint('Error in UserAccountModel.toFirestore: $e');
      rethrow;
    }
  }

  Map<String, dynamic> initiateUserAccountFalseFireStore() {
    try {
      return {
        'user': UserModel.fromEntity(user).toFirestore(),
        'join_date':
            joinDate != null ? Timestamp.fromDate(joinDate!) : Timestamp.now(),
        'is_active': isActive ?? false,
        'partner': PartnerModel.fromEntity(partner).toFireStore(),
        'role_id': roleId,
        'menu_auth': menuAuth,
        'is_initiate': isInitiate ?? false,
        'created_by': createdBy,
        'created_date': createdDate != null
            ? Timestamp.fromDate(createdDate!)
            : Timestamp.now(),
        'updated_by': updatedBy,
        'updated_date': updatedDate != null
            ? Timestamp.fromDate(updatedDate!)
            : Timestamp.now(),
        'deleted_by': deletedBy,
        'deleted_date':
            deletedDate != null ? Timestamp.fromDate(deletedDate!) : null,
        'is_deleted': isDeleted ?? false,
      };
    } catch (e) {
      debugPrint(
          'Error in UserAccountModel.initiateUserAccountFalseFireStore: $e');
      rethrow;
    }
  }

  Map<String, dynamic> initiateUserAccountByADminToFireStore() {
    try {
      return {
        'user': UserModel.fromEntity(user).toFirestore(),
        'join_date':
            joinDate != null ? Timestamp.fromDate(joinDate!) : Timestamp.now(),
        'is_active': isActive ?? false,
        'partner': PartnerModel.fromEntity(partner).toFireStore(),
        'role_id': roleId,
        'menu_auth': menuAuth,
        'is_initiate': isInitiate ?? false,
        'created_by': createdBy,
        'created_date': createdDate != null
            ? Timestamp.fromDate(createdDate!)
            : Timestamp.now(),
        'updated_by': updatedBy,
        'updated_date': updatedDate != null
            ? Timestamp.fromDate(updatedDate!)
            : Timestamp.now(),
        'deleted_by': deletedBy,
        'deleted_date':
            deletedDate != null ? Timestamp.fromDate(deletedDate!) : null,
        'is_deleted': isDeleted ?? false,
      };
    } catch (e) {
      debugPrint(
          'Error in UserAccountModel.initiateUserAccountFalseFireStore: $e');
      rethrow;
    }
  }

  Map<String, dynamic> approvalUser() {
    try {
      return {
        'user': UserModel.fromEntity(user).toFirestoreWithoutId(),
        'join_date':
            joinDate != null ? Timestamp.fromDate(joinDate!) : DateTime.now(),
        'is_active': true,
        'partner': PartnerModel.fromEntity(partner).toFireStore(),
        'role_id': roleId,
        'menu_auth': menuAuth,
        'is_initiate': isInitiate,
        'created_by': createdBy,
        'created_date': createdDate != null
            ? Timestamp.fromDate(joinDate!)
            : DateTime.now(),
        'updated_by': updatedBy,
        'updated_date': updatedDate,
        'deleted_by': deletedBy,
        'deleted_date': deletedDate,
        'is_deleted': isDeleted ?? false,
      };
    } catch (e) {
      debugPrint('Error in UserAccountModel.toFirestore: $e');
      rethrow;
    }
  }

  Map<String, dynamic> rejectingUser() {
    try {
      return {
        'user': UserModel.fromEntity(user).toFirestoreWithoutId(),
        'join_date':
            joinDate != null ? Timestamp.fromDate(joinDate!) : DateTime.now(),
        'is_active': false,
        'partner': PartnerModel.fromEntity(partner).toFireStore(),
        'role_id': roleId,
        'menu_auth': menuAuth,
        'is_initiate': isInitiate,
        'created_by': createdBy,
        'created_date': createdDate != null
            ? Timestamp.fromDate(joinDate!)
            : DateTime.now(),
        'updated_by': updatedBy,
        'updated_date': updatedDate,
        'deleted_by': deletedBy,
        'deleted_date': deletedDate,
        'is_deleted': isDeleted ?? false,
      };
    } catch (e) {
      debugPrint('Error in UserAccountModel.toFirestore: $e');
      rethrow;
    }
  }

  static List<UserAccountEntity> convertListToEntity(
      List<UserAccountModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  UserAccountModel copyWith({
    UserEntity? user,
    String? phoneNumber,
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
    return UserAccountModel(
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
      UserAccountModel(user: UserEntity.empty, partner: PartnerEntity.empty);
  @override
  bool get isEmpty => this == UserAccountModel.empty;
  @override
  bool get isNotEmpty => this != UserAccountModel.empty;
  @override
  List<Object?> get props => [
        user,
        joinDate,
        isActive,
        partner,
        roleId,
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
