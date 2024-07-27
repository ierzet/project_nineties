import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  static Page<void> page() => MaterialPage<void>(child: ForgotPasswordPage());

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                  Icon(
                    Icons.lock_reset,
                    size: AppPadding.triplePadding.r * 2,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  SizedBox(height: AppPadding.doublePadding.h),
                  Text(
                    AppStrings.forgotPassword,
                    style: AppStyles.header.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  Text(
                    AppStrings.enterYourEmail,
                    style: AppStyles.bodyText.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  CustomTextField(
                    controller: emailController,
                    type: InputType.email,
                    authFormType: AuthenticationFormType.forgotPassword,
                  ),
                  SizedBox(height: AppPadding.doublePadding.h),
                  const PrimaryButton(
                    authFormType: AuthenticationFormType.forgotPassword,
                  ),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.rememberYourPassword,
                          style: AppStyles.bodyText.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        SizedBox(width: AppPadding.halfPadding.h / 2),
                        GestureDetector(
                          // onTap: () => context.read<AppBloc>().add(
                          //     const AppUserChanged(UserAccountEntity.empty)),
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            AppStrings.signIn,
                            style: AppStyles.accentText.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ListenerNotificationLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
