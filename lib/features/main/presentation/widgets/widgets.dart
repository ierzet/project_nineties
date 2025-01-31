import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_qrcode.dart';
import 'package:qr_flutter/qr_flutter.dart';

// class AccountWidget extends StatelessWidget {
//   const AccountWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('User not authenticated'),
//         ),
//       );
//     }
//     final userModel = UserEntity.fromFirebaseUser(user);
//     final appBloc = context.read<AppBloc>().state.user;

//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundImage:
//                     userModel.photo != null && userModel.photo!.isNotEmpty
//                         ? NetworkImage(userModel.photo!)
//                         : null,
//                 radius: 50,
//                 child: userModel.photo == null || userModel.photo!.isEmpty
//                     ? const Icon(Icons.person, size: 50)
//                     : null,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 userModel.name ?? 'Unknown User',
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 userModel.email ?? 'No Email',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               MembershipCard(
//                 name: userModel.name ?? 'Unknown User',
//                 cardId: appBloc.user.id,
//                 expiryDate: '2024-12-31',
//                 qrData: 'https://example.com/qr-code-data',
//                 photoUrl: userModel.photo,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   context
//                       .read<AuthenticationValidatorBloc>()
//                       .add(const AuthenticationClearValidator());
//                   context
//                       .read<AuthenticationBloc>()
//                       .add(const AuthUserLogOut());
//                 },
//                 child: const Text('Sign out'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Messages Screen'),
            MemberQRCode(
              memberId: 'BvFHIJPgR9gtFLUg2rar',
            ),
            SizedBox(
              height: 34,
            ),
            MemberQRCode(
              memberId: 'PFoFdEpxRwWZgRgbCb52',
            ),
          ],
        ),
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

class MembersWidget extends StatelessWidget {
  const MembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Members Screen'),
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

  const MembershipCard({
    super.key,
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
          gradient: const LinearGradient(
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
                  const Column(
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'Card ID: $cardId',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'Expiry Date: $expiryDate',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 50.0,
                    // ignore: deprecated_member_use
                    foregroundColor: Colors.white,
                  ),
                  BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: cardId,
                    width: 80,
                    height: 30,
                    style: const TextStyle(color: Colors.white),
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
