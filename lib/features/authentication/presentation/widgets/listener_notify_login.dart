import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';

class ListenerNotificationLogin extends StatelessWidget {
  const ListenerNotificationLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthValidationButton ||
            state is AuthValidationRegister ||
            state is AuthValidationResetPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: Text(
                AppStrings.pleaseEnterAValidInformation,
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
            ),
          );
        } else if (state is AuthResetPasswordSuccess) {
          // context.read<AuthenticationFormCubit>().onLogin();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              content: Text(
                state.message,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
          );
        } else if (state is AuthenticationRegistered) {
          // context.read<AuthenticationFormCubit>().onLogin();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              //  backgroundColor: AppColors.accent,
              content: Text(state.result),
            ),
          );
        } else if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: Text(
                state.message,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
          );
        }
      },
      child: Container(), // You can wrap your UI widgets with BlocListener
    );
  }
}
