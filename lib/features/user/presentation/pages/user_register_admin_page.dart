import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_avatar_picker.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_custom_text_field.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_listener_notification.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_partner_dd.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_primary_button.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_role_dd.dart';

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

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.defaultPadding.h),
              const UserAvatarPicker(),
              SizedBox(height: AppPadding.defaultPadding.h),
              Text(
                'Register User by Administrator',
                style: AppStyles.header.copyWith(fontSize: 20),
              ),
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
              const UserPartnerDd(),
              SizedBox(height: AppPadding.defaultPadding.h),
              const UserRoleDd(initialValue: 'User'),
              SizedBox(height: AppPadding.doublePadding.h),
              const UserPrimaryButton(
                  authFormType: AuthenticationFormType.signup),
              const UserListenerNotification(),
            ],
          ),
        ),
      ),
    );
  }
}
