import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? photo;
  final bool? isInitiate;

  const UserEntity({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.isInitiate,
  });

  factory UserEntity.fromFirebaseUser(User firebaseUser) {
    return UserEntity(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      photo: firebaseUser.photoURL ?? '',
    );
  }

  static const empty = UserEntity(id: '');

  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? photo,
    bool? isInitiate,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      isInitiate: isInitiate ?? this.isInitiate,
    );
  }

  @override
  List<Object?> get props => [id, email, name, photo, isInitiate];
}
