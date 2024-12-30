import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/core/theme/app_theme.dart';

void main() async {
  await dotenv.load(); // Load environment variables

  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY']!);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configEasyLoading();
  runApp(const MyApp());

  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Check the list of providers
    for (UserInfo provider in user.providerData) {
      if (provider.providerId == "google.com") {
        print("User is signed in using Google.");
        return;
      }
    }
    print("User is not signed in using Google.");
  } else {
    print("No user is signed in.");
  }
}

void configEasyLoading() {
  EasyLoading.instance
    ..backgroundColor = AppColor.secondaryColor
    ..indicatorColor = AppColor.primaryColor
    ..textColor = Colors.white
    ..loadingStyle = EasyLoadingStyle.custom;
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
      builder: EasyLoading.init(),
      // home: const SignInPage(),
    );
  }
}
