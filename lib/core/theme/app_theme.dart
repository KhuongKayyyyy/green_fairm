import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_fairm/core/constant/app_color.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: false,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColor.secondaryColor,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: SlowPageTransitionBuilder(),
          TargetPlatform.android: SlowPageTransitionBuilder(),
        },
      ),
      fontFamily: GoogleFonts.nunito().fontFamily,

      // Set default text styles for the app
      textTheme: GoogleFonts.nunitoTextTheme().copyWith(
        bodyLarge: const TextStyle(fontSize: 16, color: Colors.black),
        bodyMedium: const TextStyle(fontSize: 14, color: Colors.black),
        titleLarge: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SlowPageTransitionBuilder extends PageTransitionsBuilder {
  const SlowPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0); // Slide from right
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
