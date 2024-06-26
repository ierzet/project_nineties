import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/constants.dart';

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
            onTap: () {},
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
