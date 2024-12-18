import 'package:flutter/material.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/core/theme/app_theme.dart';
import 'package:green_fairm/presentation/view/authentication/authentication_landing_page.dart';
import 'package:green_fairm/presentation/view/authentication/sign_in_page.dart';
import 'package:green_fairm/presentation/view/onboard/onboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sound Sphere',
      theme: AppTheme.theme,
      routerConfig: AppNavigation.router,
      // home: const SignInPage(),
    );
  }
}
