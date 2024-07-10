import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    required super.userId,
    super.email,
    super.name,
    super.photo,
    super.phoneNumber,
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
        userId: userId,
        email: email,
        name: name,
        photo: photo,
        phoneNumber: phoneNumber,
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
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      photo: entity.photo,
      phoneNumber: entity.phoneNumber,
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
        userId: firebaseUser.uid,
        email: firebaseUser.email,
        name: firebaseUser.displayName,
        photo: firebaseUser.photoURL,
        phoneNumber: firebaseUser.phoneNumber,
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
        'user_id': userId,
        'email': email,
        'name': name,
        'photo': photo,
        'phone_number': phoneNumber,
        'join_date':
            joinDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'is_active': isActive ?? false,
        'partner': PartnerModel.fromEntity(partner).toJson(),
        'role_id': roleId,
        'menu_auth': menuAuth,
        'is_initiate': isInitiate ?? false,
        'created_by': userId,
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
        userId: json['user_id'] ?? '',
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        photo: json['photo'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        joinDate: (json['join_date'] as Timestamp?)?.toDate(),
        isActive: json['is_active'] ?? false,
        partner: json['partner'],
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
        userId: snapshot.id,
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        photo: data['photo'] ?? '',
        phoneNumber: data['phone_number'] ?? '',
        joinDate: (data['join_date'] as Timestamp?)?.toDate(),
        isActive: data['is_active'] ?? false,
        partner: data['partner'] != null
            ? PartnerModel.fromJson(Map<String, dynamic>.from(data['partner']))
            : PartnerEntity.empty,
        roleId: data['role_id'] ?? '',
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

  // factory UserAccountModel.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   final data = snapshot.data() ?? {};
  //   try {
  //     return UserAccountModel(
  //       userId: snapshot.id,
  //       email: data['email'] ?? '',
  //       name: data['name'] ?? '',
  //       photo: data['photo'] ?? '',
  //       phoneNumber: data['phone_number'] ?? '',
  //       joinDate: (data['join_date'] as Timestamp?)?.toDate(),
  //       isActive: data['is_active'] ?? false,
  //       partner: data['partner'] != null
  //           ? PartnerModel.fromFirestore(data['partner']).toEntity()
  //           : PartnerEntity.empty,
  //       roleId: data['role_id'] ?? '',
  //       //menuAuth: data['menu_auth'] ?? [],
  //       menuAuth: List<String>.from(data['menu_auth'] ?? []),
  //       isInitiate: data['is_initiate'] ?? false,
  //       createdBy: data['created_by'],
  //       createdDate: (data['created_date'] as Timestamp?)?.toDate(),
  //       updatedBy: data['updated_by'] ?? '',
  //       updatedDate: (data['updated_date'] as Timestamp?)?.toDate(),
  //       deletedBy: data['deleted_by'] ?? '',
  //       deletedDate: (data['deleted_date'] as Timestamp?)?.toDate(),
  //       isDeleted: data['is_deleted'] ?? false,
  //     );
  //   } catch (e) {
  //     debugPrint('Error in UserAccountModel.fromFirestore: $e');
  //     rethrow;
  //   }
  // }

  Map<String, dynamic> initiateUserAccountToFirestore(
      bool newIsIntitiate, String uid) {
    try {
      return {
        'user_id': userId,
        'email': email,
        'name': name,
        'photo': photo,
        'phone_number': phoneNumber,
        'join_date':
            joinDate != null ? Timestamp.fromDate(joinDate!) : DateTime.now(),
        'is_active': isActive ?? false,
        'partner': PartnerModel.empty.toFireStore(),
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

  Map<String, dynamic> approvalUser() {
    try {
      return {
        'user_id': userId,
        'email': email,
        'name': name,
        'photo': photo,
        'phone_number': phoneNumber,
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
        'user_id': userId,
        'email': email,
        'name': name,
        'photo': photo,
        'phone_number': phoneNumber,
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
    String? userId,
    String? email,
    String? name,
    String? photo,
    String? phoneNumber,
    DateTime? joinDate,
    bool? isActive,
    dynamic partner,
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
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      phoneNumber: phoneNumber ?? this.phoneNumber,
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
      UserAccountModel(userId: '', partner: PartnerEntity.empty);
  @override
  bool get isEmpty => this == UserAccountModel.empty;
  @override
  bool get isNotEmpty => this != UserAccountModel.empty;
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
