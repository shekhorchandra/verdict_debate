import 'package:flutter/material.dart';

@immutable
class ColorScale {
  final Color s50;
  final Color s100;
  final Color s200;
  final Color s300;
  final Color s400;
  final Color s500;
  final Color s600;
  final Color s700;
  final Color s800;
  final Color s900;
  final Color s950;

  const ColorScale({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.s500,
    required this.s600,
    required this.s700,
    required this.s800,
    required this.s900,
    required this.s950,
  });

  Color get value => s600; // Updated default to 600 for better visibility
  Color call() => value;
}

abstract class AppColor {
  const AppColor._();

  /// Base Colors
  static const Color BG = Color(0xFFFFFFFF);

  /// Primary Scale (New Indigo Palette)
  static const primaryScale = ColorScale(
    s50: Color(0xFFEEF2FF),
    s100: Color(0xFFE0E7FF),
    s200: Color(0xFFC7D2FE),
    s300: Color(0xFFA5B4FC),
    s400: Color(0xFF818CF8),
    s500: Color(0xFF6366F1),
    s600: Color(0xFF4F46E5),
    s700: Color(0xFF4338CA),
    s800: Color(0xFF3730A3),
    s900: Color(0xFF312E81),
    s950: Color(0xFF1E1B4B),
  );

  static Color get primary => primaryScale.s600;
  static Color get secondary => primaryScale.s400;

  /// Neutral Scale (Keeping grays for borders/text clarity)
  static const neutral = ColorScale(
    s50: Color(0xFFFAFAFA),
    s100: Color(0xFFF5F5F5),
    s200: Color(0xFFE5E5E5),
    s300: Color(0xFFD4D4D4),
    s400: Color(0xFFA3A3A3),
    s500: Color(0xFF737373),
    s600: Color(0xFF525252),
    s700: Color(0xFF404040),
    s800: Color(0xFF262626),
    s900: Color(0xFF171717),
    s950: Color(0xFF0A0A0A),
  );

  /// Status Colors
  static const Color error = Color(0xFFDF2A16);
  static const Color warning = Color(0xFFFFBD11);
  static const Color success = Color(0xFF128635);

  /// Text Colors
  static Color onLight = neutral.s950;
  static Color onDark = neutral.s50;

  static Color get onPrimary => Colors.white;
  static Color get onSecondary => Colors.white;
  static Color get onError => Colors.white;
  static Color get onSuccess => Colors.white;
}

class AppColorScheme {
  AppColorScheme._();

  static final light = ColorScheme(
    brightness: Brightness.light,

    primary: AppColor.primary,
    onPrimary: AppColor.onPrimary,
    primaryContainer: AppColor.primaryScale.s100, // Light indigo tint
    onPrimaryContainer: AppColor.primaryScale.s900, // Deep indigo text

    secondary: AppColor.secondary,
    onSecondary: AppColor.onSecondary,
    secondaryContainer: AppColor.primaryScale.s50,
    onSecondaryContainer: AppColor.primaryScale.s700,

    error: AppColor.error,
    onError: AppColor.onError,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    surface: AppColor.BG,
    surfaceContainer: AppColor.neutral.s50,
    surfaceContainerHigh: AppColor.neutral.s100,
    surfaceContainerHighest: AppColor.neutral.s200,

    onSurface: AppColor.onLight,
    onSurfaceVariant: AppColor.neutral.s600,

    outline: AppColor.neutral.s300,
    outlineVariant: AppColor.neutral.s200,

    inverseSurface: AppColor.primaryScale.s950,
    onInverseSurface: AppColor.primaryScale.s50,

    inversePrimary: AppColor.primaryScale.s200,
  );
}