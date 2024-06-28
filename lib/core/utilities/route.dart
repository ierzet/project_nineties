import 'package:flutter/material.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/pages/authentication_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/signup_page.dart';
import 'package:project_nineties/features/main/presentation/pages/main_dashboard.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [MainDashboardPage.page()];
    case AppStatus.unauthenticated:
      return [AuthenticationPage.page()];
    case AppStatus.signup:
      return [SignupPage.page()];
    case AppStatus.forgotPassword:
      return [ForgotPasswordPage.page()];

    case AppStatus.loading:
      return [LoadingPage.page()]; // Add loading state handling
    default:
      return [ErrorPage.page()]; // Optional error handling
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  static Page page() => const MaterialPage<void>(child: LoadingPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  static Page page() => const MaterialPage<void>(child: ErrorPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Something went wrong!'),
      ),
    );
  }
}
