import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_body.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_bottom_nav_bar.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_drawer.dart';
import 'package:project_nineties/features/member/presentation/pages/member_register_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_update_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_view_extend_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_view_page.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: MainDashboardPage());
  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<AppBloc>().state.user.roleId;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MainAppBar(),
      drawer: isAdmin == 'Admin' || isAdmin == 'Superadmin'
          ? const MainDrawer()
          : null,
      body: const ResponsiveLayout(
        mobileBody: MainBody(),
        desktopBody: Center(
          child: Text('Desktop View'),
        ),
      ),
      // body: const MembersViewExtendPage(),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
