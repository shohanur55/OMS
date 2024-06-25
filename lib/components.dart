import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! App Information
const String appName = "Office Management System";
const String appVersion = "1.0.0";

class dept{
  static const List<String> department = [
    "HR Department",
    "Accounts Department",
    "Software Department",
    "Marketing Department",
  ];
  static const List<String> departments = [
    "Accounts Department",
    "Software Department",
    "Marketing Department",
  ];
}



//! Time
const int defaultDuration = 300;
const int defaultSplashScreenShow = 3;
const int apiCallTimeOut = 50;

//! Size
const Size baseScreenSize = Size(360, 800);
final double defaultPadding = 24.sp;
final double defaultMaxWidth = 400.sp;
final double defaultBoxHeight = defaultPadding * 2;

//! Border
double borderWidth2 = 1.sp;
double borderWidth3 = 0.4.sp;

//! Shadow
List<BoxShadow> shadowDown = [
  BoxShadow(
    blurRadius: borderWidth3,
    blurStyle: BlurStyle.normal,
    color: Colors.black.withOpacity(0.5),
    offset: Offset(0, borderWidth2),
  ),
];
List<BoxShadow> shadowUp = [
  BoxShadow(
    blurRadius: 1.sp,
    blurStyle: BlurStyle.normal,
    color: Colors.black,
    offset: Offset(0, -1.sp),
  ),
];

//! Theme
const Color primaryColor = Color(0xFF006E00);
Color defaultYellow = Colors.amber.shade500;

final ThemeData themeLight = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 2,
    centerTitle: false,
    shadowColor: Colors.black,
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

//! Validation
const int phoneNumberLength = 11;
const int nameMinLength = 1;
const int passwordMinLength = 1;
const String emailValidationPattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
const int otpValidationLength = 1;

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: primaryColor,
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF8DFB77),
  onPrimaryContainer: Color(0xFF002200),
  secondary: Color(0xFF54634D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD7E8CD),
  onSecondaryContainer: Color(0xFF121F0E),
  tertiary: Color(0xFF386568),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBCEBEE),
  onTertiaryContainer: Color(0xFF002022),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFDF6),
  onBackground: Color(0xFF1A1C18),
  surface: Color(0xFFFCFDF6),
  onSurface: Color(0xFF1A1C18),
  surfaceVariant: Color(0xFFDFE4D7),
  onSurfaceVariant: Color(0xFF43483F),
  outline: Color(0xFF73796E),
  onInverseSurface: Color(0xFFF1F1EB),
  inverseSurface: Color(0xFF2F312D),
  inversePrimary: Color(0xFF72DE5E),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006E00),
  outlineVariant: Color(0xFFC3C8BC),
  scrim: Color(0xFF000000),
);
