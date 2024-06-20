import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.gradient,
    required this.textColor,
    required this.authFormType,
  });

  final LinearGradient? gradient;
  final Color? textColor;
  final AuthenticationFormType authFormType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentState = context.read<AuthValidatorCubit>().state;

        final credential = RegisterAuthentication(
            email: currentState.email,
            name: currentState.name,
            password: currentState.password,
            confirmedPassword: currentState.confirmedPassword,
            avatar: currentState.avatarFile,
            avatarWeb: currentState.avatarFileWeb,
            mitraId: '',
            isWeb: currentState.isWeb);

        print(
            '7. avatarFileWeb => ambil data dari cubit untuk dikirim ke bloc currentState.avatarFileWeb: ${currentState.avatarFileWeb}');

        authFormType == AuthenticationFormType.signin
            ? context.read<AuthenticationBloc>().add(AuthEmailAndPasswordLogIn(
                  email: currentState.email,
                  password: currentState.password,
                ))
            : context
                .read<AuthenticationBloc>()
                .add(AuthUserSignUp(credential));
      },
      child: Container(
        padding: EdgeInsets.all(AppPadding.halfPadding * 3),
        margin: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding * 3),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppPadding.defaultPadding),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              offset: Offset(0, AppPadding.halfPadding / 2),
              blurRadius: AppPadding.halfPadding / 2,
            ),
          ],
        ),
        child: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return state is AuthenticationLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.background,
                    )
                  : Text(
                      authFormType == AuthenticationFormType.signin
                          ? AppStrings.signIn
                          : AppStrings.signUp,
                      style: AppStyles.buttonText,
                    );
            },
          ),
        ),
      ),
    );
  }
}
