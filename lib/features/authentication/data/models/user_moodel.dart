import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    String? email,
    String? name,
    String? photo,
  }) : super(
          email: email ?? '',
          name: name ?? '',
          photo: photo ?? '',
        );

  factory UserModel.fromFirebaseUser(User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      photo: firebaseUser.photoURL ?? '',
    );
  }

  static const empty = UserModel(id: '');
  @override
  bool get isEmpty => this == UserModel.empty;
  @override
  bool get isNotEmpty => this != UserModel.empty;
  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        name: name,
        photo: photo,
      );

  @override
  List<Object?> get props => [id, email, name, photo];
}
