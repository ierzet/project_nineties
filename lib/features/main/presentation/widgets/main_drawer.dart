import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: Text(
              'Admin Menu',
              style: AppStyles.drawerHeaderText,
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
                leading: const Icon(Icons.view_list),
                title: Text(
                  'View Users',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context.read<NavigationCubit>().updateSubMenu('view_users');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(Icons.approval),
                title: Text(
                  'User Approvals',
                  style: AppStyles.drawerItemText,
                ),
                onTap: () {
                  context
                      .read<NavigationCubit>()
                      .updateSubMenu('user_approvals');
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(
              'Partner',
              style: AppStyles.drawerItemText,
            ),
            onTap: () {
              context.read<NavigationCubit>().updateSubMenu('partner');
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: Text(
              'Customers',
              style: AppStyles.drawerItemText,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
