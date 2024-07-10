import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/features/admin/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:project_nineties/features/admin/presentation/cubit/user_validator_cubit.dart';
import 'package:project_nineties/features/admin/presentation/widgets/user_listener_notification.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';

class UserApprovalPage extends StatelessWidget {
  final UserAccountEntity user;

  const UserApprovalPage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PartnerBloc>().add(const PartnerGetData());
    final roleController = TextEditingController();
    final ddlMitraController = TextEditingController();
    String? partnerId;
    String? selectedRole;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'User Approval',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CircleAvatar(
              backgroundImage: user.photo != null && user.photo!.isNotEmpty
                  ? NetworkImage(user.photo!)
                  : const AssetImage('assets/images/profile_empty.png')
                      as ImageProvider,
              radius: 50,
            ),
            const SizedBox(height: 32),
            Text(
              user.name ?? 'No Name',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user.email ?? 'No Email',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Registration Date: ${DateFormat('yyyy-MM-dd').format(user.joinDate!)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 32),
            BlocBuilder<PartnerBloc, PartnerState>(
              builder: (context, state) {
                if (state is PartnerLoadDataSuccess) {
                  List<DropdownMenuEntry<String>> ddlMitra =
                      state.data.map((partner) {
                    return DropdownMenuEntry<String>(
                      value: partner.partnerId,
                      label: partner.partnerName ?? '',
                    );
                  }).toList();
                  return DropdownMenu<String>(
                    controller: ddlMitraController,
                    label: const Text('Mitra'),
                    enableFilter: true,
                    enableSearch: false,
                    dropdownMenuEntries: ddlMitra,
                    inputDecorationTheme: const InputDecorationTheme(
                      filled: true,
                    ),
                    onSelected: (selectedPartnerId) {
                      // final currentState = context
                      //     .read<AuthenticationValidatorBloc>()
                      //     .state
                      //     .params;
                      partnerId = selectedPartnerId ?? '';
                      // print('partnerId: $partnerId');

                      final selectedPartner = state.data.firstWhere(
                          (partner) => partner.partnerId == selectedPartnerId);
                      //print('selectedPartner: $selectedPartner');
                      //print('currentState: $currentState');
                      context
                          .read<UserValidatorCubit>()
                          .updatePartner(partner: selectedPartner);
                      // print(
                      //     "Selected PartnerId: $selectedPartnerId, Label: ${selectedPartner.partnerName}");
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownMenu<String>(
              controller: roleController,
              label: const Text('Role'),
              enableFilter: true,
              enableSearch: false,
              dropdownMenuEntries: const [
                DropdownMenuEntry<String>(
                  value: 'User',
                  label: 'User',
                ),
                DropdownMenuEntry<String>(
                  value: 'Admin',
                  label: 'Admin',
                ),
              ],
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
              ),
              onSelected: (selectedRoleId) {
                selectedRole = selectedRoleId;
                context
                    .read<UserValidatorCubit>()
                    .updateRole(role: selectedRoleId);
              },
            ),
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ApprovalButton(),
                SizedBox(width: 16),
                RejectButton(),
              ],
            ),
            const UserListenerNotification(),
          ],
        ),
      ),
    );
  }
}

class RejectButton extends StatelessWidget {
  const RejectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Rejection logic
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Reject',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class ApprovalButton extends StatelessWidget {
  const ApprovalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final updatedUserRead = context.read<AppBloc>().state.user;
    // final updatedUserWatch = context.watch<AppBloc>().state.user;
    // final updatedUserProvider = BlocProvider.of<AppBloc>(context).state.user;
    final updatedUser = context.watch<AppBloc>().state.user.id;
    // print('updatedUser watch: $updatedUserWatch');
    // print('updatedUser read: $updatedUserRead');
    // print('updatedUser provider: $updatedUserProvider');
    // print('updatedUser: $updatedUser');

    return ElevatedButton(
      onPressed: () {
        final state = context.read<UserValidatorCubit>().state;
        context.read<UserBloc>().add(UserUpdateData(
              context: context,
              updatedUser: updatedUser,
              userAccountEntity: state,
            ));
        context.read<UserValidatorCubit>().clearValidation();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Approve',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
