import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/authentication_body_mobile.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: AuthenticationPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const ResponsiveLayout(
        desktopBody: Center(
          child: Text('Desktop Body'),
        ),
        mobileBody: AuthenticationBodyMobile(),
      ),
    );
  }
}
