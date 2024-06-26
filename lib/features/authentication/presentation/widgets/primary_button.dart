import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.authFormType,
  });

  final AuthenticationFormType authFormType;

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      colors: [AppColors.accent, AppColors.primary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    void onTap() {
      final currentState = context.read<AuthValidatorCubit>().state;
      final credentialSignup = RegisterAuthentication(
          email: currentState.email,
          name: currentState.name,
          password: currentState.password,
          confirmedPassword: currentState.confirmedPassword,
          avatar: currentState.avatarFile,
          avatarWeb: currentState.avatarFileWeb,
          mitraId: '',
          isWeb: currentState.isWeb);

      final authBloc = context.read<AuthenticationBloc>();

      authFormType == AuthenticationFormType.signin
          ? authBloc.add(AuthEmailAndPasswordLogIn(
              email: currentState.email,
              password: currentState.password,
            ))
          : authFormType == AuthenticationFormType.signup
              ? authBloc.add(AuthUserSignUp(credential: credentialSignup))
              : authBloc.add(AuthResetPassword(email: currentState.email));
      context.read<AuthValidatorCubit>().clearValidation();

      //TODO: Fix bug: skenario klik button signup namun terkendala validasi. validator cubit jadi missmatch
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.defaultPadding.r),
          ),
          elevation: AppPadding.halfPadding.r / 2,
          // Add your gradient background here if needed
          // primary: AppColors.primary, // Set primary color if needed
        ),
        child: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return state is AuthenticationLoading ||
                      state is AuthenticationRegistering
                  ? const CircularProgressIndicator(
                      // color: AppColors.background,
                      )
                  : Text(
                      authFormType == AuthenticationFormType.signin
                          ? AppStrings.signIn
                          : authFormType == AuthenticationFormType.signup
                              ? AppStrings.signUp
                              : AppStrings.forgotPassword,
                      style: AppStyles.buttonText,
                    );
            },
          ),
        ),
      ),
    );
  }
}


// return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
//         margin: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
//         decoration: BoxDecoration(
//           // gradient: gradient,
//           borderRadius: BorderRadius.circular(AppPadding.defaultPadding.r),
//           boxShadow: [
//             BoxShadow(
//               //  color: AppColors.primary,
//               offset: Offset(0, AppPadding.halfPadding.r / 2),
//               blurRadius: AppPadding.halfPadding.r / 2,
//             ),
//           ],
//         ),
//         child: Center(
//           child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//             builder: (context, state) {
//               return state is AuthenticationLoading ||
//                       state is AuthenticationRegistering
//                   ? const CircularProgressIndicator(
//                       // color: AppColors.background,
//                       )
//                   : Text(
//                       authFormType == AuthenticationFormType.signin
//                           ? AppStrings.signIn
//                           : authFormType == AuthenticationFormType.signup
//                               ? AppStrings.signUp
//                               : AppStrings.forgotPassword,
//                       style: AppStyles.buttonText,
//                     );
//             },
//           ),
//         ),
//       ),
//     );