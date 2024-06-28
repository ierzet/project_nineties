import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
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
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'User',
              style: AppStyles.drawerItemText,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(
              'Partner',
              style: AppStyles.drawerItemText,
            ),
            onTap: () =>
                context.read<NavigationCubit>().updateSubMenu('partner'),
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
