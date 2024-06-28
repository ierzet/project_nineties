import 'package:flutter/material.dart';
import 'partner_avatar_picker_stub.dart'
    if (dart.library.html) 'partner_avatar_picker_web.dart'
    if (dart.library.io) 'partner_avatar_picker_mobile.dart';

class PartnerAvatarPicker extends StatelessWidget {
  const PartnerAvatarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const PartnerPlatformAvatarPicker();
  }
}
