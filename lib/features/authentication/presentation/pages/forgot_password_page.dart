import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/primary_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});
  static Page<void> page() => MaterialPage<void>(child: ForgotPasswordPage());

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
                  Icons.lock_reset,
                  size: 100,
                  color: AppColors.primary,
                ),
                SizedBox(height: AppPadding.doublePadding),
                Text(
                  'Forgot Password?',
                  style: AppStyles.header.copyWith(fontSize: 24),
                ),
                SizedBox(height: AppPadding.defaultPadding),
                Text(
                  'Enter your email to receive a reset link',
                  style: AppStyles.bodyText,
                ),
                SizedBox(height: AppPadding.defaultPadding * 2),
                CustomTextField(
                  controller: emailController,
                  type: InputType.email,
                  authFormType: AuthenticationFormType.forgotPassword,
                ),
                SizedBox(height: AppPadding.defaultPadding),
                const PrimaryButton(
                  authFormType: AuthenticationFormType.forgotPassword,
                  // onPressed: () async {
                  //   try {
                  //     await FirebaseAuth.instance.sendPasswordResetEmail(
                  //         email: emailController.text.trim());
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text('Password reset email sent'),
                  //       ),
                  //     );
                  //   } catch (e) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text('Error: ${e.toString()}'),
                  //       ),
                  //     );
                  //   }
                  // },
                ),
                SizedBox(height: AppPadding.triplePadding),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remember your password?',
                        style: AppStyles.bodyText,
                      ),
                      SizedBox(width: AppPadding.halfPadding / 2),
                      GestureDetector(
                        onTap: () => context
                            .read<AppBloc>()
                            .add(const AppUserChanged(UserEntity.empty)),
                        child: Text('Sign In', style: AppStyles.accentText),
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
    );
  }
}
