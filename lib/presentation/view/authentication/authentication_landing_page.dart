import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';
import 'package:green_fairm/presentation/widget/secondary_button.dart';

class AuthenticationLandingPage extends StatefulWidget {
  const AuthenticationLandingPage({super.key});

  @override
  State<AuthenticationLandingPage> createState() =>
      _AuthenticationLandingPageState();
}

class _AuthenticationLandingPageState extends State<AuthenticationLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            AppImage.authentication,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
          left: 20,
          right: 20,
          child: _buildAuthenticationHeader(),
        ),
        Positioned(
          bottom: 60,
          left: 20,
          right: 20,
          child: _buildAuthenticationButton(),
        )
      ],
    ));
  }

  Column _buildAuthenticationHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Green Fairm",
                style: TextStyle(
                    fontSize: 35,
                    color: Color(0xff3F7719),
                    fontWeight: FontWeight.bold)),
            Image.asset(
              AppImage.appIcon,
              width: 80,
              height: 80,
            )
          ],
        ),
        const Text(
          "Simplify your farm operations and cultivate success",
          style: TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }

  Widget _buildAuthenticationButton() {
    return Column(
      children: [
        PrimaryButton(
            text: "Sign In",
            onPressed: () {
              context.pushNamed(Routes.login);
            }),
        const SizedBox(
          height: 30,
        ),
        SecondaryButton(
            text: "Create account",
            onPressed: () {
              context.pushNamed(Routes.register);
            })
      ],
    );
  }
}
