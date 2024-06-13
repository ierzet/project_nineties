import 'package:flutter/material.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  //print(state);
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [AuthenticationPage.page()];
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('HomePage'),
    );
  }
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: AuthenticationPage());

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Authentication Page'),
    );
  }
}
