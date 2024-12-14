import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_image.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            left: 20,
            right: 20,
            child: Image.asset(
              AppImage.plant1,
              // height: 40,
              // width: 40,
            ),
          )
        ],
      ),
    );
  }
}
