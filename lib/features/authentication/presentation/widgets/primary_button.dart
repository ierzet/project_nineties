import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.authFormType,
  });

  final AuthenticationFormType authFormType;

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      final currentState =
          context.read<AuthenticationValidatorBloc>().state.params;

      final authBloc = context.read<AuthenticationBloc>();

      authFormType == AuthenticationFormType.signin
          ? authBloc.add(AuthEmailAndPasswordLogIn(params: currentState))
          : authFormType == AuthenticationFormType.signup
              ? authBloc.add(AuthUserSignUp(params: currentState))
              : authBloc.add(AuthResetPassword(email: currentState.email));

      context
          .read<AuthenticationValidatorBloc>()
          .add(const AuthenticationClearValidator());
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.defaultPadding.r),
          ),
          elevation: AppPadding.halfPadding.r / 2,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return state is AuthenticationLoading ||
                      state is AuthenticationRegistering
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Text(
                      authFormType == AuthenticationFormType.signin
                          ? AppStrings.signIn
                          : authFormType == AuthenticationFormType.signup
                              ? AppStrings.signUp
                              : AppStrings.send,
                      style: AppStyles.buttonText.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    );
            },
          ),
        ),
      ),
    );
  }
}
