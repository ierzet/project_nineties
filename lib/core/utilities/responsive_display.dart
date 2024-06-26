import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;

  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppDimensions.tabletWidth) {
          // For widths between 901 and 1200, use desktopBody
          return desktopBody;
        } else {
          // For widths less than 601, use mobileBody
          return mobileBody;
        }
      },
    );
  }
}
