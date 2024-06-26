import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

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

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    userModel.photo != null && userModel.photo!.isNotEmpty
                        ? NetworkImage(userModel.photo!)
                        : null,
                radius: 100,
                child: userModel.photo == null || userModel.photo!.isEmpty
                    ? const Text(
                        'Failed to load image',
                        textAlign: TextAlign.center,
                      )
                    : null,
              ),
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
    );
  }
}

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Messages Screen'),
      ),
    );
  }
}

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Transactions Screen'),
      ),
    );
  }
}

class CustomersWidget extends StatelessWidget {
  const CustomersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Customers Screen'),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text("Search result for '$query'"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search suggestions for '$query'"),
    );
  }
}
