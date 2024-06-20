import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    required super.userId,
    super.email,
    super.name,
    super.photo,
    super.phoneNumber,
    super.joinDate,
    super.isActive,
    super.mitraId,
    super.roleId,
    super.menuAuth,
  });

  UserAccountEntity toEntity() => UserAccountEntity(
        userId: userId,
        email: email,
        name: name,
        photo: photo,
        phoneNumber: phoneNumber,
        joinDate: joinDate,
        isActive: isActive,
        mitraId: mitraId,
        roleId: roleId,
        menuAuth: menuAuth,
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
      mitraId: entity.mitraId,
      roleId: entity.roleId,
      menuAuth: entity.menuAuth,
    );
  }
  factory UserAccountModel.fromFirebaseUser(User firebaseUser) {
    return UserAccountModel(
      userId: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      photo: firebaseUser.photoURL ?? '',
      phoneNumber: firebaseUser.phoneNumber ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'photo': photo,
      'phone_number': phoneNumber,
      'join_date': joinDate,
      'is_active': isActive,
      'mitra_id': mitraId,
      'role_id': roleId,
      'menu_auth': menuAuth,
    };
  }

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      userId: json['user_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      joinDate: (json['join_date'] as Timestamp?)?.toDate(),
      isActive: json['is_active'] ?? false,
      mitraId: json['mitra_id'] ?? '',
      roleId: json['role_id'] ?? '',
      menuAuth: json['menu_auth'] ?? [],
    );
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
        mitraId: data['mitra_id'] ?? '',
        roleId: data['role_id'] ?? '',
        menuAuth: data['menu_auth'] ?? [],
      );
    } catch (e) {
      debugPrint('Error in fromFirestore: $e');
      rethrow;
    }
  }
  static List<UserAccountEntity> convertListToEntity(
      List<UserAccountModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  static const empty = UserAccountModel(userId: '');
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
        mitraId,
        roleId,
      ];
}
