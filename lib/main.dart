import 'package:flutter/material.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Green Fairm',
      theme: AppTheme.theme,
      routerConfig: AppNavigation.router,
      // home: const SignInPage(),
    );
  }
}
