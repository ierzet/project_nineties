import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPadding {
  static double halfPadding = 8;
  static double defaultPadding = 16;
  static double doublePadding = 32;
  static double triplePadding = 48;
  static double quadruplePadding = 64;
}

class AppDimensions {
  static const double height = 896.0;
  static const double width = 414.0;
  static const double mobileWidth = 600;
  static const double tabletWidth = 970;
  static const double desktopWidth = 1200;
  static const double largeDesktopWidth = 2560;
}

class AppColors {
  static const Color primary = Color(0xFF2C3E50); // Dark Slate Blue
  static const Color secondary = Color(0xFFE74C3C); // Cinnabar Red
  static const Color accent = Color(0xFF3498DB); // Curious Blue
  static const Color background = Color(0xFFECF0F1); // Light Gray
  static const Color textColor = primary;

  // New Colors
  static const Color highlight = Color(0xFFFFD700); // Gold for highlights
  static const Color warning = Color(0xFFFFA500); // Orange for warnings
  static const Color error = Color(0xFFFF0000); // Red for errors
  static const Color success = Color(0xFF28A745); // Darker Green for success
  static const Color info = Color(0xFF17A2B8); // Light Blue for info
}
// class AppColors {
//   static const Color primary = Color(0xFFECF0F1); // Light Gray #ECF0F1
//   static const Color secondary = Color(0xFF3498DB); // Curious Blue #3498DB
//   static const Color accent = Color(0xFFE74C3C); // Cinnabar Red #E74C3C
//   static const Color background = Color(0xFF2C3E50); // Dark Slate Blue #2C3E50
//   static const Color textColor = Color(0xFFFFFFFF); // White for text
// }

class AppStrings {
  //authetication page
  static const String welcomeMessage = "Welcome back you've been missed!";
  static const String forgotPassword = 'Forgot Password?';
  static const String signIn = 'Sign In';
  static const String notAMember = 'Not a member?';
  static const String registerNow = 'Register now';
  static const String orContinueWith = 'Or continue with';
  static const String userName = 'Username';
  static const String password = 'Password';
  static const String signUp = 'Sign Up';

  //signup page
  static const String name = 'Name';
  static const String confirmedPassword = 'Confirmed password';

  //forgot password page
  static const String email = 'Email';
}

class AppStyles {
  static final TextStyle header = GoogleFonts.montserrat(
    fontSize: 16,
    // color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodyText = GoogleFonts.lato(
    fontSize: 16,
    //  color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle bodyTextBold = GoogleFonts.lato(
    fontSize: 16,
    // color: AppColors.primary,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle accentText = GoogleFonts.lato(
    fontSize: 16,
    // color: AppColors.accent,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle buttonText = GoogleFonts.montserrat(
    fontSize: 16,
    // color: AppColors.background,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle appBarTitle = GoogleFonts.montserrat(
    fontSize: 20,
    // color: AppColors.background,
    fontWeight: FontWeight.bold,
  );
  // New style for chart titles
  static final TextStyle chartTitle = GoogleFonts.montserrat(
    fontSize: 24,
    //  color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );
}

class AppPath {
  static const String googleIcon = 'assets/images/google.png';
  static const String appleIcon = 'assets/images/apple.png';
  static const String facebookIcon = 'assets/images/facebook.png';
}

enum InputType { name, email, password, confirmedPassword }

enum AuthenticationFormType { signin, signup, forgotPassword }

enum ColorSelectionMethod {
  colorSeed,
  image,
}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xFF2C3E50)),
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




// TextTheme(
//           headlineLarge: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//             fontSize: 32.0,
//             color: Color(0xFF2C3E50),
//           ),
//           bodyLarge: TextStyle(
//             fontFamily: 'Open Sans',
//             fontWeight: FontWeight.normal,
//             fontSize: 16.0,
//             color: Color(0xFF2C3E50),
//           ),
//           bodyMedium: TextStyle(
//             fontFamily: 'Open Sans',
//             fontWeight: FontWeight.normal,
//             fontSize: 14.0,
//             color: Color(0xFF2C3E50),
//           ),
//           labelLarge: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.w500,
//             fontSize: 16.0,
//             color: Colors.white,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFFE74C3C),
//             textStyle: TextStyle(
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.w500,
//               fontSize: 16.0,
//             ),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(
//               color: Color(0xFF2C3E50),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(
//               color: Color(0xFF3498DB),
//             ),
//           ),
//         ),
//       ),