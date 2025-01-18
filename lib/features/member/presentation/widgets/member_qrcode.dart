import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class MemberQRCode extends StatelessWidget {
  const MemberQRCode({
    required this.memberId,
    super.key,
  });
  final String memberId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: PrettyQrView.data(
        data: memberId,
        errorCorrectLevel: QrErrorCorrectLevel.M,
        decoration: const PrettyQrDecoration(
          image: PrettyQrDecorationImage(
            image: AssetImage('assets/images/logo_qrcoode_nineties.jpg'),
          ),
        ),
      ),
    );
  }
}
