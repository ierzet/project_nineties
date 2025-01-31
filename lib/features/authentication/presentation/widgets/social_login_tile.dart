import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';

class SocialLoginTile extends StatelessWidget {
  const SocialLoginTile({
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
          : context.read<AuthenticationBloc>().add(AuthFacebookLogin());
    }

    return GestureDetector(
      onTap: () => action(loginType),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(16),
        //   side: const BorderSide(
        //     color: AppColors.primary,
        //   ),
        // ),
        elevation: AppPadding.halfPadding.r / 2,
        shadowColor: Theme.of(context).colorScheme.shadow,
        child: Padding(
          padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
          child: Image.asset(
            imagePath,
            height: AppPadding.triplePadding.h,
          ),
        ),
      ),
    );
  }
}


// GestureDetector(
//       onTap: () => action(loginType),
//       child: Container(
//         padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
//         decoration: BoxDecoration(
//           border: Border.all(
//               // color: AppColors.primary,
//               ), // Primary Color
//           borderRadius: BorderRadius.circular(16),
//           //color: AppColors.background,
//           boxShadow: [
//             BoxShadow(
//               //color: AppColors.primary,
//               offset: Offset(0, (AppPadding.halfPadding.r / 2)),
//               blurRadius: (AppPadding.halfPadding.r / 2),
//             ),
//           ],
//         ),
//         child: Image.asset(
//           imagePath,
//           height: AppPadding.triplePadding.h,
//         ),
//       ),
//     );