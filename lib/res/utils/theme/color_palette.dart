import 'package:flutter/material.dart';

class ColorPalette {
  // 1. Create a private constructor
  const ColorPalette._private();
  // 2. static reference to your private constructor/shared reference
  static const ColorPalette _shared = ColorPalette._private();
  // 3. factory constructor reference to shared instance
  factory ColorPalette() => _shared;

  static Color primaryColor100 = const Color(0xFF000000);
  static Color failureTextColor = const Color(0xFFF84444);

  static Color appPrimaryColor = const Color(0xFF002e6e);
  static Color appSecondaryColor = Colors.white;
  // text style colours

  static Color grey80 = const Color(0xFF868686);
  static Color grey60 = const Color(0xFFB6B6B6);
  static Color grey40 = const Color(0xFFD9D9D9);
  static Color grey20 = const Color(0xFFEFEFEF);
  static Color white = const Color(0xFFEFEFEF);
  static Color grey = const Color(0xFF565656);
  static Color red = const Color(0xFFB80000);
  static Color lightGreen = const Color(0xFFE7F0E5);
  static Color mildBlack = const Color(0xFF282828);

  static Color activeDotColor = const Color(0xFF282828);
  static Color inActiveDotColor = const Color(0xFFD9D9D9);

  static Color containerBorder = const Color(0xFFE8E3DD);
  static Color arrowNextBg = const Color(0xFFB5B5B5);

  static Color becomePartnerDropDownBorder = const Color(0xFFF8F1E7);
  static Color becomePartnerDropDownBg = const Color(0xFFFFFBF6);

  static Color primaryBackgroundSelectedColor100 = const Color(0xFFE5EBFF);
  static const Color textFieldBackgroundColor100 = Color(0xFFF9FAFD);

  static Color clinicVisitBg = const Color(0xFF0C5D9C);
  static Color virtualCallBg = const Color(0xFFF79501);
  static Color inHouseVetBg = const Color(0xFF116600);
}
