import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/widgets/widgets.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppBloc>().state.user;
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 0:
          try {
            context.read<NavigationCubit>().updateSubMenu('profile');
          } catch (e) {
            debugPrint('error push: $e');
          }
          break;
        case 1:
          // Navigate to Settings
          break;
        case 2:
          // Sign Outs
          context.read<AuthenticationBloc>().add(const AuthUserLogOut());
          break;
      }
    }

    return AppBar(
      title: Text(
        '90s Car Wash',
        style: AppStyles.appBarTitle, // Using AppStyles
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [AppColors.primary, AppColors.accent], // Using AppColors
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            ),
      ),
      elevation: 10, // Elevation for shadow effect
      actions: [
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
        SizedBox(width: AppPadding.defaultPadding.w),
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle general notifications or message notifications
          },
        ),
        SizedBox(width: AppPadding.defaultPadding.w),
        PopupMenuButton<int>(
          onSelected: (item) => onSelected(context, item),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(value: 0, child: Text('Profile')),
            const PopupMenuItem<int>(value: 1, child: Text('Settings')),
            const PopupMenuItem<int>(value: 2, child: Text('Sign Out')),
          ],
          child: Padding(
            padding: EdgeInsets.only(right: AppPadding.defaultPadding.r),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 17.r,
                  backgroundImage: user.photo != null && user.photo!.isNotEmpty
                      ? NetworkImage(user.photo!)
                      : const AssetImage('assets/images/profile_empty.png'),
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors
                          .secondary, // Using AppColors for badge color
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
