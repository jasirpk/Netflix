import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/screens/splash_screen.dart';

void main() {
  runApp(Netflix_UI());
}

class Netflix_UI extends StatelessWidget {
  Netflix_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white)),
        fontFamily: GoogleFonts.ptSans().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: Splash_Screen(),
    );
  }
}
