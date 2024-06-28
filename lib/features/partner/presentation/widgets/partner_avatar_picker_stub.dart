import 'package:flutter/material.dart';

class PartnerPlatformAvatarPicker extends StatelessWidget {
  const PartnerPlatformAvatarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      width: 150,
      child: Center(child: Text('Unsupported platform')),
    );
  }
}
