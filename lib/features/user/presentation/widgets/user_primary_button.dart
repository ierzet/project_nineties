import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_validator_bloc/user_validator_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';

class UserPrimaryButton extends StatelessWidget {
  const UserPrimaryButton({
    super.key,
    required this.authFormType,
  });

  final AuthenticationFormType authFormType;

  @override
  Widget build(BuildContext context) {
    Future<void> onSubmit() async {
      final currentState = context.read<UserValidatorBloc>().state.params;
      final createdBy = context.read<AppBloc>().state.user.user.id;
      final userBloc = context.read<UserBloc>();
      bool confirm = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Warning'),
                content: const Text(
                    'If you proceed with registration, you will be automatically logged out. Do you want to continue?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          ) ??
          false;

      if (confirm) {
        final updatedState = currentState.copyWith(createdBy: createdBy);

        userBloc.add(UserRegisterByAdmin(params: updatedState));
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.defaultPadding.r),
          ),
          elevation: AppPadding.halfPadding.r / 2,
        ),
        child: Center(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return state is UserLoadInProgress
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Text(AppStrings.signUp,
                      style: AppStyles.buttonText.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ));
            },
          ),
        ),
      ),
    );
  }
}
