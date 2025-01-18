import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/route_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:project_nineties/features/authentication/presentation/pages/signup_page.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_listener_notification.dart';
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
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.triplePadding.h),
              _buildIcon(theme),
              SizedBox(height: AppPadding.triplePadding.h),
              _buildWelcomeText(theme),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildTextField(emailController, InputType.email),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildTextField(passwordController, InputType.password),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildForgotPassword(context),
              SizedBox(height: AppPadding.doublePadding.h),
              const PrimaryButton(authFormType: AuthenticationFormType.signin),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildOrContinueWithDivider(theme),
              SizedBox(height: AppPadding.doublePadding.h),
              _buildSocialLoginButtons(),
              SizedBox(height: AppPadding.defaultPadding.h),
              _buildRegisterNow(context, theme),
              const ListenerNotificationLogin(),
              const UserListenerNotification(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    return Icon(
      Icons.directions_car,
      size: AppPadding.triplePadding.r * 2,
      color: theme.colorScheme.onPrimaryContainer,
    );
  }

  Widget _buildWelcomeText(ThemeData theme) {
    return Text(
      AppStrings.welcomeMessage,
      style: AppStyles.header.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, InputType type) {
    return CustomTextField(
      controller: controller,
      type: type,
      authFormType: AuthenticationFormType.signin,
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(createPageRoute(const ForgotPasswordPage())),
            child: Text(
              AppStrings.forgotPassword,
              style: AppStyles.accentText.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrContinueWithDivider(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 2),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5.h,
              color: theme.colorScheme.outline,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding),
            child: Text(
              AppStrings.orContinueWith,
              style: AppStyles.bodyText.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5.h,
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
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
        ),
      ],
    );
  }

  Widget _buildRegisterNow(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.notAMember,
          style: AppStyles.bodyText.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        SizedBox(width: AppPadding.halfPadding.w / 2),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(createPageRoute(const SignupPage()));
            context
                .read<AuthenticationValidatorBloc>()
                .add(const AuthenticationClearValidator());
          },
          child: Text(
            AppStrings.registerNow,
            style: AppStyles.accentText.copyWith(
              decoration: TextDecoration.underline,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
