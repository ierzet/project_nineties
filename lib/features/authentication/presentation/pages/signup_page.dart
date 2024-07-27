import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/signup_body_mobile.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const ResponsiveLayout(
        desktopBody: Center(child: Text('Desktop Body')),
        mobileBody: SignupBodyMobile(),
      ),
    );
  }
}
