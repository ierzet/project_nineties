import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/avatar_picker.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';

class SignupBodyMobile extends StatelessWidget {
  const SignupBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmedPasswordController = TextEditingController();
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.doublePadding.h),
              const AvatarPicker(),
              SizedBox(height: AppPadding.doublePadding.h),
              _buildHeader(theme),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildTextField(nameController, InputType.name),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildTextField(emailController, InputType.email),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildTextField(passwordController, InputType.password),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildTextField(
                  confirmedPasswordController, InputType.confirmedPassword),
              SizedBox(height: AppPadding.doublePadding.h),
              const PrimaryButton(authFormType: AuthenticationFormType.signup),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildFooter(context),
              const ListenerNotificationLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Text(
      AppStrings.joinUs,
      textAlign: TextAlign.center,
      style: AppStyles.header.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, InputType type) {
    return CustomTextField(
      controller: controller,
      type: type,
      authFormType: AuthenticationFormType.signup,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${AppStrings.alreadyHaveAnAccount}? ',
            style: AppStyles.bodyText,
          ),
          SizedBox(width: AppPadding.halfPadding.w / 2),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              context
                  .read<AuthenticationValidatorBloc>()
                  .add(const AuthenticationClearValidator());
            },
            child: Text(AppStrings.signIn, style: AppStyles.accentText),
          ),
        ],
      ),
    );
  }
}
