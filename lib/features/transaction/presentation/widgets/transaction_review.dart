import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';

class TransactionReview extends StatelessWidget {
  const TransactionReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoadMemberSuccess) {
              final member = state.data;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // const StateNow(),
                          Center(
                            child: CircleAvatar(
                              radius: AppPadding.triplePadding.r * 3 / 2,
                              backgroundImage: member.memberPhotoOfVehicle !=
                                          null &&
                                      member.memberPhotoOfVehicle!.isNotEmpty
                                  ? NetworkImage(member.memberPhotoOfVehicle!)
                                  : const AssetImage(
                                          'assets/images/profile_empty.png')
                                      as ImageProvider,
                              onBackgroundImageError: (exception, stackTrace) {
                                debugPrint(
                                    'Error loading image: $exception,${member.memberName} ');
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            member.memberName ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: member.memberStatusMember == true
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              member.memberStatusMember == true
                                  ? 'Active'
                                  : 'Inactive',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            elevation: 4,
                            child: ExpansionTile(
                              title: const Text(
                                'Personal Information',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberPhoneNumber ??
                                                'No Phone',
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
                                            Icons.male,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          Icon(
                                            Icons.female,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberGender ?? 'No Data',
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
                                            Icons.mail,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(member.memberEmail ?? 'No Data'),
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
                              title: const Text(
                                'Vehicle Information',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Year: ',
                                          ),
                                          Text(
                                            member.memberYearOfVehicle
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.motorcycle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const Text(
                                            ' Plate Number: ',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberNoVehicle ?? 'No Data',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.directions_car_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Type : ',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberTypeOfVehicle ??
                                                'No Data',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.business,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Brand : ',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberBrandOfVehicle ??
                                                'No Data',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.height,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Size: ',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberSizeOfVehicle ??
                                                'No Data',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Variant: ',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberColorOfVehicle ??
                                                'No Data',
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
                              initiallyExpanded: true,
                              title: const Text(
                                'Membership Information',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.card_membership,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Member Type: ',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            member.memberSizeOfVehicle ??
                                                'No Data',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.app_registration,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Registration: ${member.memberRegistrationDate != null ? DateFormat.yMMMd().format(member.memberRegistrationDate!) : 'No Expiry Date'}',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.start,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Extend: ${member.memberJoinDate != null ? DateFormat.yMMMd().format(member.memberJoinDate!) : 'No Expiry Date'}',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.edgesensor_high,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Expiry: ${member.memberExpiredDate != null ? DateFormat.yMMMd().format(member.memberExpiredDate!) : 'No Expiry Date'}',
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
                              initiallyExpanded: true,
                              title: const Text(
                                'Membership History',
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
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: member.membershipHistory!.length,
                                    itemBuilder: (context, index) {
                                      final reversedIndex =
                                          member.membershipHistory!.length -
                                              1 -
                                              index;

                                      final history = member
                                          .membershipHistory![reversedIndex];

                                      return Card(
                                        elevation: 1,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.update,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Member Type:  ${history.typeOfMember}',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.date_range,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Start Date:  ${history.joinDate != null ? DateFormat.yMMMd().format(history.joinDate!) : 'No Start Date'}',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.update,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'End Date:  ${history.expiredDate != null ? DateFormat.yMMMd().format(history.expiredDate!) : 'No End Date'}',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(Icons.notes,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                      'Partner: ${history.joinPartner!.partnerName ?? 'No Notes'}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.halfPadding.w * 3),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding:
                                EdgeInsets.all(AppPadding.halfPadding.r * 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppPadding.defaultPadding.r),
                            ),
                            elevation: AppPadding.halfPadding.r / 2,
                          ),
                          onPressed: () {
                            if (member.memberExpiredDate != null &&
                                    member.memberExpiredDate!
                                        .isBefore(DateTime.now()) ||
                                member.memberStatusMember == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'This customer needs to extend first.'),
                                ),
                              );
                              return;
                            }

                            final userAccountEntity =
                                context.read<AppBloc>().state.user;
                            context.read<TransactionBloc>().add(AddTransaction(
                                  memberEntity: member,
                                  userAccountEntity: userAccountEntity,
                                ));
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Approve',
                            style: AppStyles.buttonText.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.halfPadding.w * 3),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding:
                                EdgeInsets.all(AppPadding.halfPadding.r * 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppPadding.defaultPadding.r),
                            ),
                            elevation: AppPadding.halfPadding.r / 2,
                          ),
                          onPressed: () {
                            context
                                .read<TransactionBloc>()
                                .add(const InitialState());

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Extend',
                            style: AppStyles.buttonText.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is TransactionLoadFailure) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
