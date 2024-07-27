import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/avatar_picker.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';

class SignupBodyMobile extends StatelessWidget {
  const SignupBodyMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmedPasswordController =
        TextEditingController();
    final ddlMitraController = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.doublePadding.h),
              const AvatarPicker(), // Ensure this is styled well
              SizedBox(height: AppPadding.doublePadding.h),
              Text(
                textAlign: TextAlign.center,
                AppStrings.joinUs,
                style: AppStyles.header.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              CustomTextField(
                controller: nameController,
                type: InputType.name,
                authFormType: AuthenticationFormType.signup,
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              CustomTextField(
                controller: emailController,
                type: InputType.email,
                authFormType: AuthenticationFormType.signup,
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              CustomTextField(
                controller: passwordController,
                type: InputType.password,
                authFormType: AuthenticationFormType.signup,
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              CustomTextField(
                controller: confirmedPasswordController,
                type: InputType.confirmedPassword,
                authFormType: AuthenticationFormType.signup,
              ),
              SizedBox(height: AppPadding.doublePadding.h),
              const PrimaryButton(authFormType: AuthenticationFormType.signup),
              SizedBox(height: AppPadding.defaultPadding.h),
              Center(
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
                        // Create an empty user to represent unauthenticated state
                        // const emptyUser = UserAccountEntity.empty;
                        // context
                        //     .read<AppBloc>()
                        //     .add(const AppUserChanged(emptyUser));
                        Navigator.of(context).pop();
                        context
                            .read<AuthenticationValidatorBloc>()
                            .add(const AuthenticationClearValidator());
                      },
                      child:
                          Text(AppStrings.signIn, style: AppStyles.accentText),
                    ),
                  ],
                ),
              ),
              const ListenerNotificationLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
