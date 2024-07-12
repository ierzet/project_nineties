import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not authenticated'),
        ),
      );
    }
    final userModel = UserEntity.fromFirebaseUser(user);
    final appBloc = context.read<AppBloc>().state.user;

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
                radius: 50,
                child: userModel.photo == null || userModel.photo!.isEmpty
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                userModel.name ?? 'Unknown User',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userModel.email ?? 'No Email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              MembershipCard(
                name: userModel.name ?? 'Unknown User',
                cardId: appBloc.user.id,
                expiryDate: '2024-12-31',
                qrData: 'https://example.com/qr-code-data',
                photoUrl: userModel.photo,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthenticationValidatorBloc>()
                      .add(const AuthenticationClearValidator());
                  context
                      .read<AuthenticationBloc>()
                      .add(const AuthUserLogOut());
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

class MembershipCard extends StatelessWidget {
  final String name;
  final String cardId;
  final String expiryDate;
  final String qrData;
  final String? photoUrl;

  MembershipCard({
    required this.name,
    required this.cardId,
    required this.expiryDate,
    required this.qrData,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.amber, Colors.brown],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: photoUrl != null && photoUrl!.isNotEmpty
                        ? NetworkImage(photoUrl!)
                        : null,
                    radius: 25,
                    child: photoUrl == null || photoUrl!.isEmpty
                        ? const Icon(Icons.person, size: 25)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CAR WASH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Member Card',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Name: $name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'Card ID: $cardId',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'Expiry Date: $expiryDate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 50.0,
                    foregroundColor: Colors.white,
                  ),
                  BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: cardId,
                    width: 80,
                    height: 30,
                    style: TextStyle(color: Colors.white),
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
