import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.email,
    super.name,
    super.phoneNumber,
    super.photo,
  });

  factory UserModel.fromFirebaseUser(User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
      photo: firebaseUser.photoURL,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      photo: entity.photo,
      phoneNumber: entity.phoneNumber,
    );
  }
  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        name: name,
        photo: photo,
        phoneNumber: phoneNumber,
      );

  Map<String, dynamic> toFirebase() {
    return {
      'uid': id,
      'email': email,
      'name': name,
      'photo': photo,
      'phone_number': phoneNumber
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
      'phone_number': phoneNumber
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'] as String? ?? '',
      email: json['user']['email'] as String,
      name: json['user']['name'] as String,
      photo: json['user']['photo'] as String,
      phoneNumber: json['user']['phone_number'] as String,
    );
  }
  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    return UserModel(
      id: snapshot.id,
      email: data['user']['email'],
      name: data['user']['name'],
      photo: data['user']['photo'],
      phoneNumber: data['user']['phone_number'],
    );
  }

  // Map<String, dynamic> toFirestore(String uid) {
  //   return {
  //     'id': uid,
  //     'email': email,
  //     'name': name,
  //     'photo': photo,
  //     'phone_number': phoneNumber,
  //   };
  // }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
      'phone_number': phoneNumber,
    };
  }

  Map<String, dynamic> toFirestoreWithoutId() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
      'phone_number': phoneNumber
    };
  }

  static const empty = UserModel(id: '');

  @override
  bool get isEmpty => this == UserModel.empty;

  @override
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photo,
        phoneNumber,
      ];
}
