import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/social_login_tile.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: AuthenticationPage());

  @override
  Widget build(BuildContext context) {
    // text editing controllers
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background, // Background Color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppPadding.triplePadding),
                const Icon(
                  // Icons.lock,
                  Icons.directions_car,
                  size: 100,
                  color: AppColors.primary,
                ),
                SizedBox(height: AppPadding.triplePadding),
                //Welcome back you've been missed!
                Text(
                  AppStrings.welcomeMessage,
                  style: AppStyles.header,
                ),
                SizedBox(height: AppPadding.halfPadding * 3),
                // username textfield
                CustomTextField(
                  controller: emailController,
                  type: InputType.email,
                  authFormType: AuthenticationFormType.signin,
                ),
                SizedBox(height: AppPadding.defaultPadding),
                // password textfield
                CustomTextField(
                  controller: passwordController,
                  type: InputType.password,
                  authFormType: AuthenticationFormType.signin,
                ),
                SizedBox(height: AppPadding.defaultPadding),
                // forgot password?
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.halfPadding * 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppStrings.forgotPassword,
                        style: AppStyles.accentText,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppPadding.halfPadding * 3),
                // sign in button
                const PrimaryButton(
                  gradient: LinearGradient(
                    colors: [AppColors.accent, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  textColor: AppColors.background,
                  authFormType: AuthenticationFormType.signin,
                ),
                SizedBox(height: AppPadding.triplePadding),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: AppColors.primary, // Primary Color
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          AppStrings.orContinueWith,
                          style:
                              AppStyles.bodyText, // Text Color (Primary Color)
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: AppColors.primary, // Primary Color
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppPadding.triplePadding),
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    const SocialLoginTile(
                      imagePath: AppPath.googleIcon,
                      loginType: 'google',
                    ),
                    SizedBox(width: AppPadding.halfPadding * 3),
                    // apple button
                    const SocialLoginTile(
                      imagePath: AppPath.facebookIcon,
                      loginType: 'facebook',
                    )
                  ],
                ),
                SizedBox(height: AppPadding.triplePadding),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.notAMember,
                      style: AppStyles.bodyText, // Text Color (Primary Color)
                    ),
                    SizedBox(width: AppPadding.halfPadding / 2),
                    GestureDetector(
                      onTap: () {
                        context.read<AppBloc>().add(const NavigateToSignup());
                        context.read<AuthValidatorCubit>().clearValidation();
                      },
                      child: Text(
                        AppStrings.registerNow,
                        style: AppStyles.accentText,
                      ),
                    ),
                  ],
                ),
                const ListenerNotificationLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
