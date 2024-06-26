import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_body.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_bottom_nav_bar.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: MainDashboardPage());
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: ResponsiveLayout(
        mobileBody: MainBody(),
        desktopBody: Center(
          child: Text('Desktop View'),
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(),
    );
  }
}
