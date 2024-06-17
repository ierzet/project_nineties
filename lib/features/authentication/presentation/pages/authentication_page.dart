import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: AuthenticationPage());

  @override
  Widget build(BuildContext context) {
    // text editing controllers
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    void signUserIn() {}

    return Scaffold(
      backgroundColor: const Color(0xFFECF0F1), // Background Color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppPadding.triplePadding),
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: Color(0xFF2C3E50),
                ),
                SizedBox(height: AppPadding.triplePadding),
                //Welcome back you've been missed!
                Text(
                  AppStrings.welcomeMessage,
                  style: AppStyles.header,
                ),
                SizedBox(height: AppPadding.halfPadding * 3),
                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: AppStrings.userName,
                  obscureText: false,
                ),
                SizedBox(height: AppPadding.deffaultPadding),
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: AppStrings.password,
                  obscureText: true,
                ),
                SizedBox(height: AppPadding.deffaultPadding),
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
                MyButton(
                  onTap: signUserIn,
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  textColor:
                      AppColors.background, // Background Color (Light Gray)
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
                    SquareTile(
                      imagePath: AppPath.googleIcon,
                      loginType: 'google',
                    ),
                    SizedBox(width: AppPadding.halfPadding * 3),
                    // apple button
                    SquareTile(
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
                    Text(
                      AppStrings.registerNow,
                      style: AppStyles.accentText,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final LinearGradient? gradient;
  final Color? textColor;
  const MyButton(
      {super.key, required this.onTap, this.gradient, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppPadding.halfPadding * 3),
        margin: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding * 3),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppPadding.deffaultPadding),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              offset: Offset(0, AppPadding.halfPadding / 2),
              blurRadius: AppPadding.halfPadding / 2,
            ),
          ],
        ),
        child: Center(
          child: Text(
            AppStrings.signIn,
            style: AppStyles.buttonText,
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding * 3),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.primary), // Primary Color for enabled border
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.accent), // Accent Color for focused border
          ),
          fillColor: AppColors
              .background, // Slightly darker shade for the text field background
          filled: true,
          hintText: hintText,
          hintStyle:
              TextStyle(color: AppColors.textColor), // Text color for hint
        ),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.loginType,
  });
  final String imagePath;
  final String loginType;

  @override
  Widget build(BuildContext context) {
    void action(loginType) {
      loginType == 'google'
          ? context.read<AuthenticationBloc>().add(AuthGoogleLogIn())
          : context
              .read<AuthenticationBloc>()
              .add(AuthFacebookLogin()); //TODO: ganti sama appple id
    }

    return GestureDetector(
      onTap: () => action(loginType),
      child: Container(
        padding: EdgeInsets.all(AppPadding.halfPadding * 3),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary), // Primary Color
          borderRadius: BorderRadius.circular(16),
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              offset: Offset(0, AppPadding.halfPadding / 2),
              blurRadius: AppPadding.halfPadding / 2,
            ),
          ],
        ),
        child: Image.asset(
          imagePath,
          height: AppPadding.triplePadding,
        ),
      ),
    );
  }
}
