import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/domain/usecases/confirmed_password.dart';
import 'package:project_nineties/features/authentication/domain/usecases/email.dart';
import 'package:project_nineties/features/authentication/domain/usecases/password.dart';
import 'dart:io' as io;

import 'package:universal_html/html.dart';
part 'auth_validator_state.dart';

class AuthValidatorCubit extends Cubit<AuthValidatorCubitState> {
  AuthValidatorCubit() : super(AuthValidatorCubitState.empty);

  void clearValidation() {
    emit(AuthValidatorCubitState.empty);
  }

  void validateAuthCredentials({
    required String email,
    required String password,
  }) {
    final emailObj = Email.dirty(email);
    final passwordObj = Password.dirty(password);

    emit(
      AuthValidatorCubitState(
        emailIsValid: emailObj.isValid,
        passwordIsValid: passwordObj.isValid,
        email: email,
        password: password,
        nameIsValid: false,
        confirmedPasswordIsValid: false,
        name: '',
        confirmedPassword: '',
      ),
    );
  }

  void validateSignupCredentials({
    required String name,
    required String email,
    required String password,
    required String confirmedPassword,
    io.File? avatarFile,
    File? avatarFileWeb,
    bool? isWeb,
  }) {
    final emailObj = Email.dirty(email);
    final passwordObj = Password.dirty(password);
    final confirmedPasswordObj = ConfirmedPassword.dirty(
      password: password,
      value: confirmedPassword,
    );

    emit(
      AuthValidatorCubitState(
          nameIsValid: name.isNotEmpty,
          emailIsValid: emailObj.isValid,
          passwordIsValid: passwordObj.isValid,
          confirmedPasswordIsValid: confirmedPasswordObj.isValid,
          name: name,
          email: email,
          password: password,
          confirmedPassword: confirmedPassword,
          avatarFile: avatarFile,
          avatarFileWeb: avatarFileWeb,
          isWeb: isWeb),
    );
  }

  void validateForgotPasswordCredential({
    required String email,
  }) {
    final emailObj = Email.dirty(email);

    emit(
      AuthValidatorCubitState(
        emailIsValid: emailObj.isValid,
        passwordIsValid: false,
        email: email,
        password: '',
        nameIsValid: false,
        confirmedPasswordIsValid: false,
        name: '',
        confirmedPassword: '',
      ),
    );
  }
}
