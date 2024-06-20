import 'dart:io' as io;
import 'package:equatable/equatable.dart';
import 'package:universal_html/html.dart';

class RegisterAuthentication extends Equatable {
  final String email;
  final String name;
  final String password;
  final String confirmedPassword;
  final io.File? avatar;
  final File? avatarWeb;
  final String mitraId;
  final bool? isWeb;

  const RegisterAuthentication(
      {required this.email,
      required this.name,
      required this.password,
      required this.confirmedPassword,
      required this.avatar,
      required this.avatarWeb,
      required this.mitraId,
      required this.isWeb});

  static const empty = RegisterAuthentication(
      email: '',
      name: '',
      password: '',
      confirmedPassword: '',
      avatar: null,
      avatarWeb: null,
      mitraId: '',
      isWeb: null);

  bool get isEmpty => this == RegisterAuthentication.empty;
  bool get isNotEmpty => this != RegisterAuthentication.empty;

  RegisterAuthentication copyWith({
    String? email,
    String? name,
    String? password,
    String? confirmedPassword,
    io.File? avatar,
    File? avatarWeb,
    String? mitraId,
    bool? isWeb,
  }) {
    return RegisterAuthentication(
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        avatar: avatar ?? this.avatar,
        avatarWeb: avatarWeb ?? this.avatarWeb,
        mitraId: mitraId ?? this.mitraId,
        isWeb: isWeb ?? this.isWeb);
  }

  @override
  List<Object?> get props => [
        email,
        name,
        password,
        confirmedPassword,
        avatar,
        avatarWeb,
        mitraId,
        isWeb
      ];
}
