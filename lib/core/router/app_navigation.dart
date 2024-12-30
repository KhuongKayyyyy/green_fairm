import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/view/authentication/authentication_landing_page.dart';
import 'package:green_fairm/presentation/view/authentication/reset_password_page.dart';
import 'package:green_fairm/presentation/view/authentication/verification_page.dart';
import 'package:green_fairm/presentation/view/authentication/register_page.dart';
import 'package:green_fairm/presentation/view/authentication/set_up_information_page.dart';
import 'package:green_fairm/presentation/view/authentication/sign_in_page.dart';
import 'package:green_fairm/presentation/view/chat/chat_page.dart';
import 'package:green_fairm/presentation/view/field_detail/field_detail_page.dart';
import 'package:green_fairm/presentation/view/main/field/field_page.dart';
import 'package:green_fairm/presentation/view/main/home/homepage.dart';
import 'package:green_fairm/presentation/view/main/news/news_page.dart';
import 'package:green_fairm/presentation/view/main/profile/profile_detail_page.dart';
import 'package:green_fairm/presentation/view/main/profile/profile_page.dart';
import 'package:green_fairm/presentation/view/main/profile/update_password_page.dart';
import 'package:green_fairm/presentation/view/main/profile/change_pass_otp_verification.dart';
import 'package:green_fairm/presentation/view/main_wrapper/main_wrapper.dart';
import 'package:green_fairm/presentation/view/setting/set_up_successfully.dart';
import 'package:green_fairm/presentation/view/setting/setting_landing_page.dart';
import 'package:green_fairm/presentation/view/setting/set_up_farm.dart';
import 'package:green_fairm/presentation/view/weather_detail/weather_detail_page.dart';

class AppNavigation {
  static bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeNavigator');
  static final GlobalKey<NavigatorState> _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profileNavigator');
  static final GlobalKey<NavigatorState> _newsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeNavigator');
  static final GlobalKey<NavigatorState> _fieldNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profileNavigator');

  static final GlobalKey<NavigatorState> _paddingNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'paddingNavigator');
  static final GoRouter router = GoRouter(
      initialLocation: isLoggedIn ? Routes.home : Routes.authenticate_landing,
      // redirect: (context, state) {
      //   final loggedIn = isLoggedIn; // Replace with your actual login check
      //   final goingToLogin = state.subloc == Routes.authenticate_landing;

      //   if (!loggedIn && !goingToLogin) {
      //     return Routes.authenticate_landing;
      //   } else if (loggedIn && goingToLogin) {
      //     return Routes.home;
      //   }
      //   return null;
      // },
      routes: [
        _buildMainShellRoute(),
        ..._buildAuthenticationRoute(),
        ..._buildSetUpFarmRoute(),
      ],
      navigatorKey: _rootNavigatorKey);

  static StatefulShellRoute _buildMainShellRoute() {
    return StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainWrapper(navigationShell: navigationShell),
        branches: [
          _buildHomeBranch(),
          _buildNewsBranch(),
          _buildPaddingBranch(),
          _buildFieldBranch(),
          _buildProfileBranch(),
        ]);
  }

  static List<GoRoute> _buildSetUpFarmRoute() {
    return [
      GoRoute(
        path: Routes.settingLanding,
        name: Routes.settingLanding,
        builder: (context, state) => const SettingLandingPage(),
      ),
      GoRoute(
        path: Routes.settingDetail,
        name: Routes.settingDetail,
        builder: (context, state) => const SetUpFarmPage(),
      ),
      GoRoute(
        path: Routes.setUpSuccess,
        name: Routes.setUpSuccess,
        builder: (context, state) => const SetUpSuccessfully(),
      )
    ];
  }

  static List<GoRoute> _buildAuthenticationRoute() {
    return [
      GoRoute(
        path: Routes.authenticate_landing,
        name: Routes.authenticate_landing,
        builder: (context, state) => const AuthenticationLandingPage(),
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: Routes.register,
        name: Routes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: Routes.mailVerification,
        name: Routes.mailVerification,
        builder: (context, state) => const VerificationPage(),
      ),
      GoRoute(
        path: Routes.setUpInforamtion,
        name: Routes.setUpInforamtion,
        builder: (context, state) => const SetupInformationPage(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        name: Routes.forgotPassword,
        builder: (context, state) => const ResetPasswordPage(),
      )
    ];
  }

  static StatefulShellBranch _buildPaddingBranch() {
    return StatefulShellBranch(
      navigatorKey: _paddingNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.padding,
          name: Routes.padding,
          builder: (context, state) => const SizedBox(),
        ),
      ],
    );
  }

  static StatefulShellBranch _buildHomeBranch() {
    return StatefulShellBranch(
      navigatorKey: _homeNavigatorKey,
      routes: [
        // GoRoute(
        //     path: Routes.onboarding,
        //     name: Routes.onboarding,
        //     builder: (context, state) => const OnboardPage()),
        GoRoute(
          path: Routes.home, // Home path
          name: Routes.home,
          builder: (context, state) => const Homepage(),
        ),
        GoRoute(
          path: Routes.chat,
          name: Routes.chat,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ChatPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              final tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        )
      ],
    );
  }

  static StatefulShellBranch _buildNewsBranch() {
    return StatefulShellBranch(
      navigatorKey: _newsNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.news,
          name: Routes.news,
          builder: (context, state) => const NewsPage(),
        )
      ],
    );
  }

  static StatefulShellBranch _buildFieldBranch() {
    return StatefulShellBranch(
      navigatorKey: _fieldNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.field,
          name: Routes.field,
          builder: (context, state) => const FieldPage(),
        ),
        GoRoute(
            path: Routes.fieldDetail,
            name: Routes.fieldDetail,
            builder: (context, state) {
              final extra = state.extra;
              final field = extra as Field;
              return FieldDetailPage(field: field);
            }),
        GoRoute(
            path: Routes.weatherDetail,
            name: Routes.weatherDetail,
            builder: (context, state) => const WeatherDetailPage())
      ],
    );
  }

  static StatefulShellBranch _buildProfileBranch() {
    return StatefulShellBranch(
      navigatorKey: _profileNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.profile,
          name: Routes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: Routes.profileDetail,
          name: Routes.profileDetail,
          builder: (context, state) => const ProfileDetailPage(),
        ),
        GoRoute(
          path: Routes.updatePassword,
          name: Routes.updatePassword,
          builder: (context, state) => const UpdatePasswordPage(),
        ),
        GoRoute(
          path: Routes.changePassOtp,
          name: Routes.changePassOtp,
          builder: (context, state) => const ChangePassOtpVerification(),
        ),
        // GoRoute(
        //     path: Routes.settingLanding,
        //     name: Routes.settingLanding,
        //     builder: (context, state) => const SettingLandingPage()),
      ],
    );
  }
}
