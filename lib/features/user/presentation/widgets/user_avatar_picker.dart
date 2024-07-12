import 'package:flutter/material.dart';

import 'user_avatar_picker_stub.dart'
    if (dart.library.html) 'user_avatar_picker_web.dart'
    if (dart.library.io) 'user_avatar_picker_mobile.dart';

class UserAvatarPicker extends StatelessWidget {
  const UserAvatarPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const UserPlatformAvatarPicker();
  }
}
