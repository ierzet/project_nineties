import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/route_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/signup_page.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_register_page.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_listener_notification.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/social_login_tile.dart';

class AuthenticationBodyMobile extends StatelessWidget {
  const AuthenticationBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.triplePadding.h),
              Icon(
                Icons.directions_car,
                size: AppPadding.triplePadding.r * 2,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              SizedBox(height: AppPadding.triplePadding.h),
              Text(
                AppStrings.welcomeMessage,
                style: AppStyles.header.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              CustomTextField(
                controller: emailController,
                type: InputType.email,
                authFormType: AuthenticationFormType.signin,
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              CustomTextField(
                controller: passwordController,
                type: InputType.password,
                authFormType: AuthenticationFormType.signin,
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.defaultPadding.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      // onTap: () => context
                      //     .read<AppBloc>()
                      //     .add(const NavigateToForgotPassword()),
                      onTap: () => Navigator.of(context)
                          .push(createPageRoute(const ForgotPasswordPage())),

                      child: Text(
                        AppStrings.forgotPassword,
                        style: AppStyles.accentText.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppPadding.doublePadding.h),
              const PrimaryButton(authFormType: AuthenticationFormType.signin),
              SizedBox(height: AppPadding.defaultPadding.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.halfPadding.w * 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5.h,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.halfPadding),
                      child: Text(
                        AppStrings.orContinueWith,
                        style: AppStyles.bodyText.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.outline,
                        thickness: 0.5.h,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppPadding.doublePadding.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SocialLoginTile(
                    imagePath: AppPath.googleIcon,
                    loginType: 'google',
                  ),
                  SizedBox(width: AppPadding.halfPadding.w * 3),
                  const SocialLoginTile(
                    imagePath: AppPath.facebookIcon,
                    loginType: 'facebook',
                  )
                ],
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.notAMember,
                    style: AppStyles.bodyText.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(width: (AppPadding.halfPadding.w / 2)),
                  GestureDetector(
                    onTap: () {
                      // context.read<AppBloc>().add(const NavigateToSignup());
                      Navigator.of(context)
                          .push(createPageRoute(const SignupPage()));
                      context
                          .read<AuthenticationValidatorBloc>()
                          .add(const AuthenticationClearValidator());
                    },
                    child: Text(
                      AppStrings.registerNow,
                      style: AppStyles.accentText.copyWith(
                          decoration: TextDecoration.underline,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
              const ListenerNotificationLogin(),
              const UserListenerNotification(),
            ],
          ),
        ),
      ),
    );
  }
}
