import 'package:cloud_firestore/cloud_firestore.dart';
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

enum Feature {
  member,
  useraccount,
  partner,
  transaction,
  setting,
  message,
}

class AppCollection {
  static const memberCollection = 'member';
  static const userAccountCollection = 'user_account';
  static const partnerCollection = 'partner';
  static const transactionCollection = 'transaction';
  static const messageCollection = 'message';
}
// class AppColors {
//   static const Color primary = Color(0xFFECF0F1); // Light Gray #ECF0F1
//   static const Color secondary = Color(0xFF3498DB); // Curious Blue #3498DB
//   static const Color accent = Color(0xFFE74C3C); // Cinnabar Red #E74C3C
//   static const Color background = Color(0xFF2C3E50); // Dark Slate Blue #2C3E50
//   static const Color textColor = Color(0xFFFFFFFF); // White for text
// }

String maskDate(String date) {
  String formattedDate = date.replaceAll('Z', '');

  return formattedDate;
}

// Helper method to parse date
DateTime? parseDateApp(dynamic date) {
  if (date is Timestamp) {
    return date.toDate();
  } else if (date is String) {
    return DateTime.parse(date);
  }
  return null; // Return null if the date is neither Timestamp nor String
}

enum BackendType {
  firebase,
  api,
}

class AppBackendConfig {
  static const String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2Nzk2NjBlNWE5YzExOWE0YWQxYjgzM2UiLCJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJyb2xlIjoidXNlciIsImlhdCI6MTczODA3NjI1NywiZXhwIjoxNzM4MDk0MjU3fQ.Q1PVyb1WtOWrsS44XGLL2rbiTkxAkEcDGovivNLGGzE';
  static const BackendType readBackend = BackendType.api;
  static const BackendType writeBackend = BackendType.api;
}

class AppStrings {
  static const String appName = '90s Car Wash';

  //halaman autentikasi
  static const String welcomeMessage = "Selamat datang kembali!";
  static const String forgotPassword = 'Lupa Kata Sandi?';
  static const String signIn = 'Masuk';
  static const String notAMember = 'Belum menjadi anggota?';
  static const String registerNow = 'Daftar sekarang';
  static const String orContinueWith = 'atau lanjutkan dengan';
  static const String userName = 'Nama Pengguna';
  static const String password = 'Kata Sandi';
  static const String signUp = 'Daftar';
  static const String dataIsNotValid = 'Data tidak valid';

  //halaman pendaftaran
  static const String name = 'Nama';
  static const String confirmedPassword = 'Konfirmasi kata sandi';
  static const String joinUs = 'Bergabunglah untuk pengalaman terbaik!';
  static const String failedToPickImage = 'Gagal memilih gambar';
  static const String alreadyHaveAnAccount = 'Apakah Anda sudah memliki akun';

  //halaman lupa kata sandi
  static const String email = 'Email';

  static const String pleaseEnterAValidInformation =
      'Harap masukkan informasi yang valid.';

  //halaman lupa password
  static const String enterYourEmail =
      'Masukkan email Anda untuk menerima tautan reset';
  static const String rememberYourPassword = 'Ingat kata sandi Anda?';
  static const String send = 'Kirim';

  //halaman dashboard
  static const String dashboard = 'Dashboard';
  static const String transactionTrends = 'Transaction Trends';
  static const String memberGrowth = 'Member Growth';
  static const String userActivities = 'User Activities';

  //drawer
  static const String adminMenu = 'Admin Menu';
}

String toTitleCase(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text
      .split(' ')
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word)
      .join(' ');
}

class AppStyles {
  static final TextStyle header = GoogleFonts.lato(
    fontSize: 24,
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

  static final TextStyle buttonText = GoogleFonts.lato(
    fontSize: 16,
    // color: AppColors.background,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle appBarTitle = GoogleFonts.lato(
    fontSize: 24,
    color: AppColors.background,
    fontWeight: FontWeight.bold,
  );
  // New style for chart titles
  static final TextStyle chartTitle = GoogleFonts.lato(
    fontSize: 22,
    //  color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );
  // New style for drawer header text
  static final TextStyle drawerHeaderText = GoogleFonts.lato(
    fontSize: 22,
    //color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  // New style for drawer item text
  static final TextStyle drawerItemText = GoogleFonts.lato(
    fontSize: 18,
    // color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );
}

class AppMasterList {
  static List<String> generateYearList() {
    int currentYear = DateTime.now().year;
    return List<String>.generate(
        currentYear - 1945 + 1, (index) => (1945 + index).toString());
  }

  static List<String> masterListGender = ['Male', 'Female', 'No Data'];
  static List<String> masterListTypeOfVehicle = ['MOTOR', 'MOBIL', 'No Data'];
  static List<String> masterListYearOfVehicle = generateYearList();
  static List<String> masterListStatusMember = [
    'Active',
    'Inactive',
    'No Data'
  ];
  static List<String> masterListTypeOfMember = [
    'Platinum',
    'Gold',
    'Silver',
    'Kecubung',
    "Family Plan",
    "Member Perorangan",
    "Member",
    "No Data"
  ];
  static List<String> masterListSizeOfVehicle = [
    'Small',
    'Medium',
    'Large',
    'large',
    'Motor',
    'No Data',
  ];
  static List<String> masterListBrandOfVehicle = [
    "AVANZA",
    "BEETLE",
    "BMW",
    "CHEVROLET",
    "CHEVROLST",
    "DAIHATSU",
    "DATSUN",
    "DAYHATSU",
    "DODGE",
    "ETIOS",
    "FORD",
    "FORTUNER",
    "GLORY",
    "HARLEY",
    "HODA",
    "HONDA",
    "HRV",
    "HYUNDAI",
    "INMOVA",
    "INNOVA",
    "INOVA",
    "ISUZU",
    "JEEP",
    "KAWASAKI",
    "KIA",
    "MAZDA",
    "MERCEDESBENZ",
    "MERCY",
    "MG",
    "MHITSUBITSI",
    "MIBIL",
    "MISTUBISHI",
    "MITSHUBISHI",
    "MITSUBISHI",
    "MITSUBISI",
    "MITSUBITSHI",
    "MITSUBULISHI",
    "MOBIL",
    "MOTOR",
    "NISAN",
    "NISSAN",
    "PAJERO",
    "PAJEROSPORT",
    "PIAGGIO",
    "PIAGIO",
    "PORSCE",
    "PORSCHE",
    "RANGEROVER",
    "REANAULT",
    "RUSH",
    "SUBARU",
    "SUZUKI",
    "SUZUXI",
    "TOYOTA",
    "TRAIL",
    "VESPA",
    "VW",
    "WULING",
    "YAMAHA",
    "YAMAJA",
    'No Data',
  ];
}

class AppPath {
  static const String googleIcon = 'assets/images/google.png';
  static const String appleIcon = 'assets/images/apple.png';
  static const String facebookIcon = 'assets/images/facebook.png';
}

enum InputType {
  name,
  email,
  password,
  confirmedPassword,
  phone,
  gender,
  date,
  joinDate,
  expiredDate,
  dOBDate,
  vehicleType,
  vehicleNo,
  vehicleColor,
  address,
  memberType,
  statusMember,
  text,
  registrationDate,
  year,
}

enum AuthenticationFormType { signin, signup, forgotPassword }

enum DropDownType { register, update }

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
  naughtyRed('Cinnabar Red', Color(0xFFE74C3C)),
  lightGrey('Light Grey', Color(0xFFECF0F1)),
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
