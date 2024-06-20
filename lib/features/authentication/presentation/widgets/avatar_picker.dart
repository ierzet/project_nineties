import 'package:flutter/material.dart';

// Import the correct platform-specific implementation
import 'avatar_picker_stub.dart'
    if (dart.library.html) 'avatar_picker_web.dart'
    if (dart.library.io) 'avatar_picker_mobile.dart';

class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const PlatformAvatarPicker();
  }
}
