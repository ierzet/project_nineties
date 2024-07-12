import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_validator_bloc/user_validator_bloc.dart';
import 'package:project_nineties/features/user/presentation/cubit/user_validator_cubit.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_avatar_picker.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_custom_text_field.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_listener_notification.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_primary_button.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';

class UserRegisterAdminPage extends StatelessWidget {
  const UserRegisterAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PartnerBloc>().add(const PartnerGetData());
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmedPasswordController =
        TextEditingController();

    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppPadding.doublePadding.h),
            SizedBox(height: AppPadding.doublePadding.h),
            const UserAvatarPicker(),
            SizedBox(height: AppPadding.defaultPadding.h),
            UserCustomTextField(
              controller: nameController,
              type: InputType.name,
              authFormType: AuthenticationFormType.signup,
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            UserCustomTextField(
              controller: emailController,
              type: InputType.email,
              authFormType: AuthenticationFormType.signup,
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            UserCustomTextField(
              controller: passwordController,
              type: InputType.password,
              authFormType: AuthenticationFormType.signup,
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            UserCustomTextField(
              controller: confirmedPasswordController,
              type: InputType.confirmedPassword,
              authFormType: AuthenticationFormType.signup,
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            const PartnerDropDown(),
            const SizedBox(height: 16),
            const RoldeDropDown(),
            const SizedBox(height: 16),
            SizedBox(height: AppPadding.halfPadding.h * 3),
            const UserPrimaryButton(
                authFormType: AuthenticationFormType.signup),
            const UserListenerNotification(),
          ],
        ),
      ),
    );
  }
}

class PartnerDropDown extends StatelessWidget {
  const PartnerDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final ddlMitraController = TextEditingController();
    String? partnerId;

    return BlocBuilder<PartnerBloc, PartnerState>(
      builder: (context, state) {
        if (state is PartnerLoadDataSuccess) {
          List<DropdownMenuEntry<String>> ddlMitra = state.data.map((partner) {
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
              partnerId = selectedPartnerId ?? '';

              final selectedPartner = state.data.firstWhere(
                  (partner) => partner.partnerId == selectedPartnerId);

              final currentState =
                  context.read<UserValidatorBloc>().state.params;
              context.read<UserValidatorBloc>().add(UserValidatorForm(
                  params: currentState.copyWith(partner: selectedPartner)));
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class RoldeDropDown extends StatelessWidget {
  const RoldeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final roleController = TextEditingController();
    String? selectedRole;
    return DropdownMenu<String>(
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
        final currentState = context.read<UserValidatorBloc>().state.params;
        selectedRole = selectedRoleId;
        context.read<UserValidatorBloc>().add(UserValidatorForm(
            params: currentState.copyWith(roleId: selectedRole)));
      },
    );
  }
}
