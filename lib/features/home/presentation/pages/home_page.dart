import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/data/models/user_moodel.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case when user is not authenticated
      return const Scaffold(
        body: Center(
          child: Text('User not authenticated'),
        ),
      );
    }

    final userModel = UserModel.fromFirebaseUser(user);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userModel.photo!),
              radius: 50,
            ),
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/project-nineties.appspot.com/o/user_image%2Fuser_profile%2FdLsqVy1gHsgMiRXpPBAsklLsMg83?alt=media&token=64302c40-8122-40a7-93e5-7bc77a6c544d',
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Text('Failed to load image');
              },
            ),
            const SizedBox(height: 16),
            Text('Name: ${userModel.name}'),
            const SizedBox(height: 8),
            Text('Email: ${userModel.email}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(const AuthUserLogOut());
                context.read<AuthValidatorCubit>().clearValidation();
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
