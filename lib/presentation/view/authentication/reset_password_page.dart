import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildResetBackground(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                children: [
                  _buildResetPasswordHeader(),
                  const SizedBox(height: 130),
                  _buildResetPasswordForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Email",
          hintText: "Enter your email",
          controller: emailController,
          icon: CupertinoIcons.mail,
        ),
        const SizedBox(height: 100),
        PrimaryButton(
          text: "Reset Password",
          onPressed: () async {
            if (emailController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter your email")),
              );
              return;
            } else {
              // Send password reset email
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: emailController.text);

              // Simulate a loading process
              EasyLoading.show(status: 'Processing...');
              await Future.delayed(const Duration(seconds: 1));
              EasyLoading.dismiss();

              // Show success or error message
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password reset email sent!"),
                ),
              );
              // ignore: use_build_context_synchronously
              context.pop(); // Navigate back
            }
          },
        ),
      ],
    );
  }

  List<Widget> _buildResetBackground() {
    return [
      Positioned(
        top: 100,
        left: -120,
        child: Hero(
          tag: "plant1",
          child: Transform.rotate(
            angle: 30 * 3.1415927 / 180, // 45 degrees to radians
            child: Image.asset(AppImage.plant1, scale: 2),
          ),
        ),
      ),
      Positioned(
        bottom: -10,
        left: -60,
        child: Hero(
          tag: "plant2",
          child: Image.asset(AppImage.plant2, scale: 1.5),
        ),
      ),
      Positioned(
        top: 60,
        left: 15,
        child: ActionButtonIcon(
          icon: CupertinoIcons.chevron_left,
          isGreen: true,
          onPressed: () => context.pop(),
        ),
      ),
    ];
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.defaultBold()),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          cursorColor: AppColor.secondaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            prefixIconColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return AppColor.secondaryColor;
              }
              return Colors.grey;
            }),
            fillColor: AppColor.primaryColor.withOpacity(0.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColor.secondaryColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetPasswordHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Reset Password",
            style: AppTextStyle.largeBold(color: AppColor.secondaryColor)),
        Text(
          "Enter your email to reset your password",
          style: AppTextStyle.defaultBold(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
