import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator/authentication_validator_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.type,
    required this.authFormType,
  });

  final TextEditingController controller;
  final InputType type;
  final AuthenticationFormType authFormType;

  @override
  Widget build(BuildContext context) {
    void onChanged(value) {
      final currentState =
          context.read<AuthenticationValidatorBloc>().state.params;
      final email = type == InputType.email ? value : currentState.email;
      final password =
          type == InputType.password ? value : currentState.password;
      final name = type == InputType.name ? value : currentState.name;
      final confirmedPassword = type == InputType.confirmedPassword
          ? value
          : currentState.confirmedPassword;

      authFormType == AuthenticationFormType.signin
          ? context
              .read<AuthenticationValidatorBloc>()
              .add(AuthenticationValidatorForm(
                  params: currentState.copyWith(
                email: email,
                password: password,
              )))
          : authFormType == AuthenticationFormType.signup
              ? context
                  .read<AuthenticationValidatorBloc>()
                  .add(AuthenticationValidatorForm(
                      params: currentState.copyWith(
                    email: email,
                    password: password,
                    name: name,
                    confirmedPassword: confirmedPassword,
                    avatarFile: currentState.avatarFile,
                    avatarFileWeb: currentState.avatarFileWeb,
                    isWeb: currentState.isWeb,
                  )))
              : context
                  .read<AuthenticationValidatorBloc>()
                  .add(AuthenticationValidatorForm(
                      params: currentState.copyWith(
                    email: email,
                  )));
    }

    final bool obscureText =
        type == InputType.password || type == InputType.confirmedPassword;
    final List<TextInputFormatter> inputFormatters = [
      LengthLimitingTextInputFormatter(100),
      if (type == InputType.email)
        FilteringTextInputFormatter.allow(RegExp(r'[0-9@a-zA-Z.]')),
    ];

    final keyboardType = type == InputType.name
        ? TextInputType.name
        : type == InputType.email
            ? TextInputType.emailAddress
            : type == InputType.password
                ? TextInputType.text
                : TextInputType.text;
    final labelText = type == InputType.name
        ? AppStrings.name
        : type == InputType.email
            ? AppStrings.email
            : type == InputType.password
                ? AppStrings.password
                : AppStrings.confirmedPassword;

    final inputDecoration = InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            // color: AppColors.primary,
            ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            //  color: AppColors.accent,
            ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            //  color: AppColors.secondary,
            ),
      ),
      labelText: labelText,
      labelStyle: AppStyles.bodyText,
      //fillColor: AppColors.background,
      filled: true,
      hintStyle: const TextStyle(
          // color: AppColors.textColor,
          ),
      suffixIcon: BlocBuilder<AuthenticationValidatorBloc,
          AuthenticationValidatorState>(
        builder: (context, state) {
          final isValid = type == InputType.name
              ? state.params.isNameValid
              : type == InputType.email
                  ? state.params.isEmailValid
                  : type == InputType.password
                      ? state.params.isPasswordValid
                      : state.params.isConfirmedPasswordValid;

          return isValid
              ? const Icon(
                  Icons.verified,
                  // color: AppColors.accent,
                )
              : const SizedBox.shrink();
        },
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: inputDecoration,
      ),
    );
  }
}
