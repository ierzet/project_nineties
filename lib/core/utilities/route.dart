import 'package:flutter/material.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/pages/authentication_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/signup_page.dart';
import 'package:project_nineties/features/home/presentation/pages/home_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [AuthenticationPage.page()];
    // return [SignupPage.page()];
    case AppStatus.signup:
      return [SignupPage.page()];
    case AppStatus.forgotPassword:
      return [ForgotPasswordPage.page()];
  }
}
