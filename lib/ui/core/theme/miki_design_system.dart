import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MikiColors {
  // Pastel Japanese Palette
  static const Color background = Color(0xFFF6F6F6);
  static const Color text = Color(0xFF373D4A);
  static const Color lavender = Color(0xFFC9CBF4);
  static const Color iceBlue = Color(0xFFD0EEF4);
  static const Color rosePink = Color(0xFFF6C9C9);

  // Derived Brand Colors (from Stitch mockup)
  static const Color primary = Color(0xFF6B6E94);
  static const Color primaryContainer = Color(0xFFE0E1F9);
  static const Color primaryFixedDim = Color(0xFFC1C3EC);
  static const Color onPrimaryContainer = Color(0xFF525578);

  static const Color secondary = Color(0xFF5A7A7F);
  static const Color secondaryContainer = Color(0xFFE0F2F5);
  static const Color onSecondaryContainer = Color(0xFF4D696E);

  static const Color tertiary = Color(0xFF8A6666);
  static const Color tertiaryContainer = Color(0xFFFCE4E4);
  static const Color onTertiaryContainer = Color(0xFF704F4F);

  static const Color outline = Color(0xFF8E8D96);
  static const Color outlineVariant = Color(0xFFD9D8DF);
}

class MikiTextStyles {
  // Plus Jakarta Sans for Headlines
  static TextStyle headlineLg({Color color = MikiColors.primary}) => 
      GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
        letterSpacing: -0.02 * 32,
        color: color,
      );

  static TextStyle headlineMd({Color color = MikiColors.primary}) => 
      GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 28 / 22,
        color: color,
      );

  static TextStyle headlineSm({Color color = MikiColors.primary}) => 
      GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 24 / 18,
        color: color,
      );

  // Manrope for Body & Labels
  static TextStyle bodyLg({Color color = MikiColors.text}) => 
      GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        height: 28 / 18,
        color: color,
      );

  static TextStyle bodyMd({Color color = MikiColors.text}) => 
      GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 22 / 15,
        color: color,
      );

  static TextStyle labelMd({Color color = MikiColors.text}) => 
      GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 18 / 13,
        letterSpacing: 0.04 * 13,
        color: color,
      );

  static TextStyle labelSm({Color color = MikiColors.primary}) => 
      GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 16 / 11,
        letterSpacing: 0.08 * 11,
        color: color,
      );
}

class MikiDecorations {
  static BoxDecoration glassMorphism({
    double borderRadius = 16,
    Color borderColor = const Color(0x7fffffff), // border white/50
    Color bgColor = const Color(0x66ffffff),     // bg white/40
  }) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: 1.0),
    );
  }
}
