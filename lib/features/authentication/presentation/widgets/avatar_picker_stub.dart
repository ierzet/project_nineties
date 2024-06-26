import 'package:flutter/material.dart';

class PlatformAvatarPicker extends StatelessWidget {
  const PlatformAvatarPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      // color: Colors.red,
      child: const Center(child: Text('Unsupported platform')),
    );
  }
}
