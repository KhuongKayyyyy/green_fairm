import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    user?.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        EasyLoading.showSuccess("Email verified");
        timer.cancel();
        context.go(Routes.home);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildVerificationBackground(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                children: [
                  _buildVerificationHeader(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: PrimaryButton(
              onPressed: () {
                user?.sendEmailVerification();
              },
              text: "Resend Verification",
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildVerificationBackground() {
    return [
      Positioned(
        top: 0,
        right: -50,
        child: Hero(
          tag: "plant1",
          child: Transform.rotate(
            angle: -45 * 3.1415927 / 180,
            child: Image.asset(AppImage.plant1, scale: 2),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: -50,
        child: Hero(
          tag: "plant2",
          child: Image.asset(AppImage.plant2, scale: 1.5),
        ),
      ),
    ];
  }

  Widget _buildVerificationHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Verify Your Email",
            style: AppTextStyle.largeBold(color: AppColors.secondaryColor)),
        const SizedBox(height: 60),
        Text(
          "A verification email has been sent to your email address. Please verify your email to continue.",
          style: AppTextStyle.defaultBold(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
