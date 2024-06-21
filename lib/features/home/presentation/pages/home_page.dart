import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
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

    final userModel = UserEntity.fromFirebaseUser(user);
    final appBlocState = context.watch<AppBloc>().state.user;
    // print(appBlocState.name);
    // print(appBlocState.email);
    // print(appBlocState.isEmpty);
    // print(appBlocState);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   backgroundImage: userModel.photo != null
                //       ? NetworkImage(
                //           userModel.photo!,
                //           // Provide an error builder for NetworkImage directly
                //         ) as ImageProvider
                //       : null,
                //   radius: 50,

                //   child:
                //       userModel.photo == null ? Text('Failed to load image') : null,
                // ),
                CircleAvatar(
                  backgroundImage:
                      userModel.photo != null && userModel.photo!.isNotEmpty
                          ? NetworkImage(userModel.photo!)
                          : null,
                  radius: 50,
                  child: userModel.photo == null || userModel.photo!.isEmpty
                      ? const Text(
                          'Failed to load image',
                          textAlign: TextAlign.center,
                        )
                      : null,
                ),
                Image.network(
                  userModel.photo!,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Text('Failed to load image');
                  },
                ),
                // Image.network(
                //   'https://firebasestorage.googleapis.com/v0/b/project-nineties.appspot.com/o/user_image%2Fuser_profile%2FdLsqVy1gHsgMiRXpPBAsklLsMg83?alt=media&token=64302c40-8122-40a7-93e5-7bc77a6c544d',
                //   errorBuilder: (BuildContext context, Object exception,
                //       StackTrace? stackTrace) {
                //     return Text('Failed to load image');
                //   },
                // ),
                const SizedBox(height: 16),
                Text('Name: ${userModel.name}'),
                const SizedBox(height: 8),
                Text('Email: ${userModel.email}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(const AuthUserLogOut());
                    context.read<AuthValidatorCubit>().clearValidation();
                  },
                  child: const Text('Sign out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
