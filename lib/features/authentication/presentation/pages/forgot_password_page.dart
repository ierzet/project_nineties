import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: ForgotPasswordPage());

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: ResponsiveLayout(
        desktopBody: const Center(
          child: Text('Desktop Body'),
        ),
        mobileBody: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppPadding.doublePadding.h),
                  _buildIcon(theme),
                  SizedBox(height: AppPadding.doublePadding.h),
                  _buildHeader(theme),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  _buildSubHeader(theme),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  _buildEmailField(emailController),
                  SizedBox(height: AppPadding.doublePadding.h),
                  const PrimaryButton(
                    authFormType: AuthenticationFormType.forgotPassword,
                  ),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  _buildFooter(context, theme),
                  const ListenerNotificationLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    return Icon(
      Icons.lock_reset,
      size: AppPadding.triplePadding.r * 2,
      color: theme.colorScheme.onPrimaryContainer,
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Text(
      AppStrings.forgotPassword,
      style: AppStyles.header.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildSubHeader(ThemeData theme) {
    return Text(
      AppStrings.enterYourEmail,
      style: AppStyles.bodyText.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return CustomTextField(
      controller: controller,
      type: InputType.email,
      authFormType: AuthenticationFormType.forgotPassword,
    );
  }

  Widget _buildFooter(BuildContext context, ThemeData theme) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.rememberYourPassword,
            style: AppStyles.bodyText.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: AppPadding.halfPadding.h / 2),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              AppStrings.signIn,
              style: AppStyles.accentText.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
