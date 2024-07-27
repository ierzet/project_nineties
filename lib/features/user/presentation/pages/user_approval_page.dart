import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:project_nineties/features/user/presentation/cubit/user_validator_cubit.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_listener_notification.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_partner_dd.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_role_dd.dart';

class UserApprovalPage extends StatelessWidget {
  const UserApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PartnerBloc>().add(const PartnerGetData());
    final user = context.read<UserValidatorCubit>().state;
    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.defaultPadding.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.defaultPadding.h),
              CircleAvatar(
                backgroundImage:
                    user.user.photo != null && user.user.photo!.isNotEmpty
                        ? NetworkImage(user.user.photo!)
                        : const AssetImage('assets/images/profile_empty.png')
                            as ImageProvider,
                radius: AppPadding.triplePadding.r * 3 / 2,
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              Text(
                user.user.name ?? 'No Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(height: AppPadding.halfPadding.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user.user.email ?? 'No Email',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppPadding.halfPadding.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: AppPadding.halfPadding.w),
                  Text(
                    'Registration Date: ${DateFormat('yyyy-MM-dd').format(user.joinDate!)}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Divider(height: AppPadding.doublePadding.h),
              UserPartnerDd(
                initialValue: user.partner.partnerId,
                dropDownType: DropDownType.update,
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              UserRoleDd(
                initialValue: user.roleId ?? 'User',
                dropDownType: DropDownType.update,
              ),
              Divider(height: AppPadding.doublePadding.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ApprovalButton(),
                  SizedBox(width: AppPadding.defaultPadding.w),
                  const RejectButton(),
                ],
              ),
              const UserListenerNotification(),
            ],
          ),
        ),
      ),
    );
  }
}

class RejectButton extends StatelessWidget {
  const RejectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Rejection logic
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
  const ApprovalButton({super.key});

  @override
  Widget build(BuildContext context) {
    final updatedUser = context.watch<AppBloc>().state.user.user.id;

    return ElevatedButton(
      onPressed: () {
        final state = context.read<UserValidatorCubit>().state;
        context.read<UserBloc>().add(UserApproval(
              context: context,
              updatedUser: updatedUser,
              userAccountEntity: state,
            ));
        context.read<UserValidatorCubit>().clearValidation();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Approve',
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
