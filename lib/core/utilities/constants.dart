import 'package:flutter/material.dart';

class Constans {
  static String imagesPath = 'assets/images/';
  static String svgsPath = 'assets/svg_pictures/';
  static String iconPath = 'assets/icons/';

  static double deffaultPadding = 16;
  static double halfPadding = 8;
  static double doublePadding = 32;
  static double triplePadding = 48;
  static double quadruplePadding = 64;

  static Color basicWhite = const Color.fromRGBO(254, 254, 254, 1.0);
  static Color dirtyWhite = const Color.fromRGBO(249, 249, 249, 1.0);
  static Color inputdecor = const Color.fromRGBO(237, 237, 237, 1.0);
  static Color accentColor = const Color.fromRGBO(238, 140, 33, 1.0);
}

enum ColorSelectionMethod {
  colorSeed,
  image,
}

enum ColorSeed {
  baseColor('M3 Baseline', Colors.orange),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

enum ColorImageProvider {
  leaves('Leaves',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_1.png'),
  peonies('Peonies',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png'),
  bubbles('Bubbles',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_3.png'),
  seaweed('Seaweed',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_4.png'),
  seagrapes('Sea Grapes',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_5.png'),
  petals('Petals',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_6.png');

  const ColorImageProvider(this.label, this.url);
  final String label;
  final String url;
}
