import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userAccount = context.read<AppBloc>().state.user;

    final String userName = userAccount.user.name ?? 'No Name';
    final String userEmail = userAccount.user.email ?? 'No Email';
    final String userProfilePic =
        userAccount.user.photo ?? 'assets/images/profile_empty.png';
    final String userRole = userAccount.roleId ?? 'No Role';
    final String userPhone = userAccount.user.phoneNumber ?? 'No Phone Number';
    final String partnerName =
        userAccount.partner.partnerName ?? 'No Partner Name';
    final String partnerEmail =
        userAccount.partner.partnerEmail ?? 'No Partner Email';
    final String partnerPhone =
        userAccount.partner.partnerPhoneNumber ?? 'No Partner Phone';
    final String partnerLocation =
        userAccount.partner.partnerAddress ?? 'No Partner Address';
    final String partnerProfilePic = userAccount.partner.partnerImageUrl ??
        'assets/images/profile_empty.png';
    final String userJoinDate = userAccount.joinDate != null
        ? DateFormat.yMMMd().format(userAccount.joinDate!)
        : 'Unknown';
    final String partnerJoinDate = userAccount.partner.partnerJoinDate != null
        ? DateFormat.yMMMd().format(userAccount.partner.partnerJoinDate!)
        : 'Unknown';
    final String userStatus =
        userAccount.isActive == true ? 'Active' : 'Inactive';
    final String partnerStatus = userAccount.partner.partnerStatus ?? 'Unknown';

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      // bottomNavigationBar: const MainBottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: AppPadding.triplePadding.r * 3 / 2,
                  backgroundImage: NetworkImage(userProfilePic),
                  onBackgroundImageError: (_, __) {},
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userRole,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text(
                    'User Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Joined: $userJoinDate',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                userPhone,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Status: $userStatus',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: userStatus == 'Active'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: ExpansionTile(
                  initiallyExpanded: false,
                  title: const Text(
                    'Partner Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/profile_empty.png',
                                    image: partnerProfilePic,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/profile_empty.png',
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    partnerName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    partnerLocation,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(partnerEmail),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(partnerPhone),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text('Joined: $partnerJoinDate'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text('Status: $partnerStatus'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
