import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:project_nineties/core/usecases/name.dart';
import 'package:project_nineties/features/authentication/domain/usecases/confirmed_password.dart';
import 'package:project_nineties/features/authentication/domain/usecases/email.dart';
import 'package:project_nineties/features/authentication/domain/usecases/password.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'dart:io' as io;
import 'package:universal_html/html.dart';

class AuthenticationParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final String confirmedPassword;
  final io.File? avatarFile;
  final File? avatarFileWeb;
  final bool? isWeb;
  final PartnerEntity partner;

  const AuthenticationParams({
    required this.email,
    required this.password,
    required this.name,
    required this.confirmedPassword,
    this.avatarFile,
    this.avatarFileWeb,
    this.isWeb,
    required this.partner,
  });

  static const empty = AuthenticationParams(
    email: '',
    password: '',
    name: '',
    confirmedPassword: '',
    avatarFile: null,
    avatarFileWeb: null,
    isWeb: null,
    partner: PartnerEntity.empty,
  );

  bool get isEmpty => this == AuthenticationParams.empty;
  bool get isNotEmpty => this != AuthenticationParams.empty;

  bool get isNameValid => Name.dirty(name.toString()).isValid;
  bool get isEmailValid => Email.dirty(email.toString()).isValid;
  bool get isPasswordValid => Password.dirty(password.toString()).isValid;
  bool get isConfirmedPasswordValid => ConfirmedPassword.dirty(
        password: password,
        value: confirmedPassword,
      ).isValid;

  bool get isValidSignUp {
    final nameObj = Name.dirty(name);
    final emailObj = Email.dirty(email);
    final passwordObj = Password.dirty(password);
    final confirmedPasswordObj = ConfirmedPassword.dirty(
      password: password,
      value: confirmedPassword,
    );

    return Formz.validate(
        [nameObj, emailObj, passwordObj, confirmedPasswordObj]);
  }

  bool get isValidSignin {
    final emailObj = Email.dirty(email);
    final passwordObj = Password.dirty(password);

    return Formz.validate([emailObj, passwordObj]);
  }

  AuthenticationParams copyWith({
    String? email,
    String? password,
    String? name,
    String? confirmedPassword,
    io.File? avatarFile,
    File? avatarFileWeb,
    bool? isWeb,
    PartnerEntity? partner,
  }) {
    return AuthenticationParams(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      avatarFile: avatarFile ?? this.avatarFile,
      avatarFileWeb: avatarFileWeb ?? this.avatarFileWeb,
      isWeb: isWeb ?? this.isWeb,
      partner: partner ?? this.partner,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        name,
        confirmedPassword,
        avatarFile,
        avatarFileWeb,
        isWeb,
        partner,
      ];
}
