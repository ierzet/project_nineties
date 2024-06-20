import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/avatar_picker.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController =
      TextEditingController();

  SignupPage({super.key});
  static Page<void> page() => MaterialPage<void>(child: SignupPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppPadding.doublePadding),
                const Icon(
                  Icons.local_car_wash,
                  size: 100,
                  color: AppColors.primary,
                ),
                SizedBox(height: AppPadding.doublePadding),
                const AvatarPicker(), // Ensure this is styled well
                SizedBox(height: AppPadding.defaultPadding),
                Text(
                  'Join us for a top-notch experience!',
                  style: AppStyles.header.copyWith(fontSize: 20),
                ),
                SizedBox(height: AppPadding.defaultPadding),
                CustomTextField(
                  controller: nameController,
                  type: InputType.name,
                  authFormType: AuthenticationFormType.signup,
                ),
                SizedBox(height: AppPadding.defaultPadding),
                CustomTextField(
                  controller: emailController,
                  type: InputType.email,
                  authFormType: AuthenticationFormType.signup,
                ),
                SizedBox(height: AppPadding.defaultPadding),
                CustomTextField(
                  controller: passwordController,
                  type: InputType.password,
                  authFormType: AuthenticationFormType.signup,
                ),
                SizedBox(height: AppPadding.defaultPadding),
                CustomTextField(
                  controller: confirmedPasswordController,
                  type: InputType.confirmedPassword,
                  authFormType: AuthenticationFormType.signup,
                ),
                SizedBox(height: AppPadding.halfPadding * 3),
                const Center(
                  child: PrimaryButton(
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: AppColors.background,
                    authFormType: AuthenticationFormType.signup,
                  ),
                ),
                SizedBox(height: AppPadding.triplePadding),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: AppStyles.bodyText,
                      ),
                      SizedBox(width: AppPadding.halfPadding / 2),
                      GestureDetector(
                        onTap: () {
                          // Create an empty user to represent unauthenticated state
                          const emptyUser = UserAccountEntity.empty;
                          context
                              .read<AppBloc>()
                              .add(const AppUserChanged(emptyUser));
                          context.read<AuthValidatorCubit>().clearValidation();
                        },
                        child: Text('Sign In', style: AppStyles.accentText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
