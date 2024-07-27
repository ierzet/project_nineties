import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppBloc>().state.user;
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 0:
          try {
            context.read<NavigationCubit>().updateSubMenuWithAnimated(
                context: context, subMenu: 'profile');
          } catch (e) {
            debugPrint('error push: $e');
          }
          break;
        case 1:
          context
              .read<NavigationCubit>()
              .updateSubMenuWithAnimated(context: context, subMenu: 'settings');
          break;
        case 2:
          // Sign Outs
          context.read<AuthenticationBloc>().add(const AuthUserLogOut());
          break;
      }
    }

    return AppBar(
      title: BlocBuilder<NavigationCubit, NavigationCubitState>(
        builder: (context, state) {
          final navigationCubit = context.read<NavigationCubit>();
          return Text(
            navigationCubit.getAppBarTitle(),
            style: AppStyles.appBarTitle.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ), // Using AppStyles
          );
        },
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      elevation: 10, // Elevation for shadow effect
      actions: [
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
                  radius: 18.r,
                  backgroundImage:
                      user.user.photo != null && user.user.photo!.isNotEmpty
                          ? NetworkImage(user.user.photo!)
                          : const AssetImage('assets/images/profile_empty.png'),
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}

class MainAppBarNoAvatar extends StatelessWidget
    implements PreferredSizeWidget {
  const MainAppBarNoAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppBloc>().state.user;
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 0:
          try {
            context.read<NavigationCubit>().updateSubMenuWithAnimated(
                context: context, subMenu: 'profile');
          } catch (e) {
            debugPrint('error push: $e');
          }
          break;
        case 1:
          context
              .read<NavigationCubit>()
              .updateSubMenuWithAnimated(context: context, subMenu: 'settings');
          break;
        case 2:
          // Sign Outs
          context.read<AuthenticationBloc>().add(const AuthUserLogOut());
          break;
      }
    }

    return AppBar(
      title: BlocBuilder<NavigationCubit, NavigationCubitState>(
        builder: (context, state) {
          final navigationCubit = context.read<NavigationCubit>();
          return Text(
            navigationCubit.getAppBarTitle(),
            style: AppStyles.appBarTitle.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ), // Using AppStyles
          );
        },
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      elevation: 10, // Elevation for shadow effect
      actions: [
        Padding(
          padding: EdgeInsets.only(right: AppPadding.defaultPadding.r),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundImage:
                    user.user.photo != null && user.user.photo!.isNotEmpty
                        ? NetworkImage(user.user.photo!)
                        : const AssetImage('assets/images/profile_empty.png'),
                backgroundColor: Colors.transparent,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: const BoxDecoration(
                    color:
                        AppColors.secondary, // Using AppColors for badge color
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
