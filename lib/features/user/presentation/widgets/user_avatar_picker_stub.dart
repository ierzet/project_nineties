import 'package:flutter/material.dart';

class UserPlatformAvatarPicker extends StatelessWidget {
  const UserPlatformAvatarPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      width: 150,
      // color: Colors.red,
      child: Center(child: Text('Unsupported platform')),
    );
  }
}
