import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EffigyTheme {
  /// [ Colors ]
  static const Color white = Colors.white;

  /// [ Theme properties ]

  static ThemeData get theme => ThemeData(
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      );
}
