import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.directions_car,
                    size: AppPadding.doublePadding.r * 2,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(height: AppPadding.defaultPadding.h),
                Flexible(
                  child: Center(
                    child: Text(
                      AppStrings.adminMenu,
                      style: AppStyles.drawerHeaderText.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            leading: const Icon(Icons.person),
            title: Text(
              'User',
              style: AppStyles.drawerItemText,
            ),
            childrenPadding: const EdgeInsets.only(
                left: 16.0), // Optional for better alignment
            children: [
              ListTile(
                leading: const Icon(Icons.approval),
                title: Text(
                  'Register User',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'register_user_admin');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_list),
                title: Text(
                  'View Users',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'users_view');
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.business),
            title: Text(
              'Partner',
              style: AppStyles.drawerItemText,
            ),
            childrenPadding: const EdgeInsets.only(
                left: 16.0), // Optional for better alignment
            children: [
              ListTile(
                leading: const Icon(Icons.approval),
                title: Text(
                  'Register Partner',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'partner');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_list),
                title: Text(
                  'View Partners',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'partners_view');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_list),
                title: Text(
                  'Partners Screen',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'partner_screen');
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.people),
            title: Text(
              'Member',
              style: AppStyles.drawerItemText,
            ),
            childrenPadding: const EdgeInsets.only(
                left: 16.0), // Optional for better alignment
            children: [
              ListTile(
                leading: const Icon(Icons.approval),
                title: Text(
                  'Register Member',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'member_register');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(Icons.group_add_outlined),
                title: Text(
                  'Extend Member',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'member_view_extend');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: Text(
                  'View Members',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'member_view');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: Text(
                  'Migrate Data Members',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'migrate_data_members');
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.credit_card),
            title: Text(
              'Transaction',
              style: AppStyles.drawerItemText,
            ),
            childrenPadding: const EdgeInsets.only(
                left: 16.0), // Optional for better alignment
            children: [
              ListTile(
                leading: const Icon(Icons.view_list),
                title: Text(
                  'View Transaction',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenuWithAnimated(
                      context: context, subMenu: 'transaction_view');
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
