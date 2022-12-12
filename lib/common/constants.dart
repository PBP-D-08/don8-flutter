import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const API_URL = "https://don8-proyek-ts.up.railway.app";

// Colors
const Color darkColor = Color(0xFF000000);
const Color lightColor = Color(0xFFFFFFFF);
const Color greenDark = Color(0xFF003e44);
const Color greenMedium = Color(0xFF006d77);
const Color greenLight = Color(0xFF83C5BE);
const Color brokenWhite = Color(0xFFEDF6F9);
const Color orangeDark = Color(0xFFCC6842);
const Color orangeMedium = Color(0xFFE29578);
const Color orangeLight = Color(0xFFFFDDD2);

const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

// Text Style
final TextStyle defaultText = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: medium,
  letterSpacing: 0.25,
  color: greenMedium,
);

final TextStyle primaryText = GoogleFonts.poppins(
  fontSize: 23,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.25,
  color: greenMedium,
);

final TextStyle appBarText = GoogleFonts.poppins(
  fontSize: 32,
  fontWeight: bold,
  color: brokenWhite,
);

final TextStyle heading2 = GoogleFonts.poppins(
  fontSize: 57,
  fontWeight: bold,
  letterSpacing: -0.5,
  color: greenDark,
);
final TextStyle heading3 = GoogleFonts.poppins(
  fontSize: 46,
  fontWeight: regular,
  color: greenDark,
);
final TextStyle heading4 = GoogleFonts.poppins(
  fontSize: 32,
  fontWeight: regular,
  letterSpacing: 0.25,
  color: greenDark,
);
final TextStyle heading5 = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: regular,
  color: greenDark,
);
final TextStyle heading6 = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: medium,
  letterSpacing: 0.15,
  color: greenDark,
);

// text theme
final TextTheme myTextTheme = GoogleFonts.poppinsTextTheme().copyWith(
  headline2: heading2,
  headline3: heading3,
  headline4: heading4,
  headline5: heading5,
  headline6: heading6,
  bodyText1: primaryText,
  bodyText2: defaultText, // flutter default selected text style
);

const customScheme = ColorScheme(
    brightness: Brightness.light,
    primary: greenMedium,
    onPrimary: brokenWhite,
    primaryContainer: greenMedium,
    onPrimaryContainer: orangeMedium,
    secondary: orangeLight,
    onSecondary: orangeDark,
    error: Colors.red,
    onError: darkColor,
    background: brokenWhite,
    onBackground: greenDark,
    surface: greenDark,
    onSurface: orangeMedium);

// theme data
ThemeData customTheme = ThemeData(
  scaffoldBackgroundColor: brokenWhite,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  colorScheme: customScheme,
  appBarTheme:
      AppBarTheme(backgroundColor: greenMedium, titleTextStyle: appBarText),
);
