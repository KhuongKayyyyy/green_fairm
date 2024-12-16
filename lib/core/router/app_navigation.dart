import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/view/authentication/authentication_landing_page.dart';
import 'package:green_fairm/presentation/view/authentication/otp_verification_page.dart';
import 'package:green_fairm/presentation/view/authentication/register_page.dart';
import 'package:green_fairm/presentation/view/authentication/sign_in_page.dart';
import 'package:green_fairm/presentation/view/field_detail/field_detail_page.dart';
import 'package:green_fairm/presentation/view/main/field/field_page.dart';
import 'package:green_fairm/presentation/view/main/home/homepage.dart';
import 'package:green_fairm/presentation/view/main/news/news_page.dart';
import 'package:green_fairm/presentation/view/main/profile/profile_page.dart';
import 'package:green_fairm/presentation/view/main_wrapper/main_wrapper.dart';
import 'package:green_fairm/presentation/view/onboard/onboard_page.dart';

class AppNavigation {
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
      initialLocation: Routes.home,
      routes: [
        _buildMainShellRoute(),
        ..._buildAuthenticationRoute(),
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
        path: Routes.otpVerification,
        name: Routes.otpVerification,
        builder: (context, state) => const OtpVerificationPage(),
      ),
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
            })
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
        )
      ],
    );
  }
}
