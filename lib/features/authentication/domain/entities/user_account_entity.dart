import 'package:equatable/equatable.dart';

class UserAccountEntity extends Equatable {
  final String userId;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final DateTime? joinDate;
  final String? photo;
  final bool? isActive;
  final String? mitraId;
  final String? roleId;
  final List<String>? menuAuth;
  final bool? isInitiate;

  const UserAccountEntity({
    required this.userId,
    this.email,
    this.name,
    this.phoneNumber,
    this.joinDate,
    this.photo,
    this.isActive,
    this.mitraId,
    this.roleId,
    this.menuAuth,
    this.isInitiate,
  });

  UserAccountEntity copyWith({
    String? userId,
    String? email,
    String? name,
    String? phoneNumber,
    DateTime? joinDate,
    String? photo,
    bool? isActive,
    String? mitraId,
    String? roleId,
    List<String>? menuAuth,
    bool? isInitiate,
  }) {
    return UserAccountEntity(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      joinDate: joinDate ?? this.joinDate,
      photo: photo ?? this.photo,
      isActive: isActive ?? this.isActive,
      mitraId: mitraId ?? this.mitraId,
      roleId: roleId ?? this.roleId,
      menuAuth: menuAuth ?? this.menuAuth,
      isInitiate: isInitiate ?? this.isInitiate,
    );
  }

  static const empty = UserAccountEntity(userId: '');

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
        mitraId,
        roleId,
        menuAuth,
        isInitiate
      ];
}
