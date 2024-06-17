import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('HomePage'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(const AuthUserLogOut());
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
