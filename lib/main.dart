import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Flutter Bloc package
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/core/theme/app_theme.dart';
import 'package:green_fairm/data/res/user_repository.dart';
import 'package:green_fairm/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart'; // Example bloc

void main() async {
  await dotenv.load(); // Load environment variables

  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY']!);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configEasyLoading();
  runApp(const MyApp());

  User user = FirebaseAuth.instance.currentUser!;
  if (user.metadata.creationTime == user.metadata.lastSignInTime) {
    // The user is new
    print('New user');
  } else {
    // The user is not new
    print('Existing user');
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc()..add(AuthenticationEventStarted()),
        ),
        BlocProvider<FieldManagementBloc>(
          create: (context) => FieldManagementBloc(),
        ),
        // Add more BlocProviders as needed
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Green Fairm',
        theme: AppTheme.theme,
        routerConfig: AppNavigation.router,
        builder: EasyLoading.init(),
      ),
    );
  }
}
