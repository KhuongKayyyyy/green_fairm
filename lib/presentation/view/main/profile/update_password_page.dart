import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/border_text_field.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  String requirement = "Password must be at least 6 characters";

  @override
  void initState() {
    super.initState();
    print(user?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.profileBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Text(
                "Update Password",
                textAlign: TextAlign.center,
                style: AppTextStyle.mediumBold(color: Colors.white),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: ActionButtonIcon(
                icon: CupertinoIcons.chevron_left,
                onPressed: () => context.pop(),
              ),
            ),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: _buildUpdatePasswordForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatePasswordForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(requirement, style: AppTextStyle.defaultBold()),
            const SizedBox(height: 20),
            BorderTextField(
              controller: passwordController,
              obscureText: true,
              hintText: "",
              labelText: "Password",
              icon: CupertinoIcons.lock_circle,
            ),
            const SizedBox(height: 20),
            BorderTextField(
              controller: newPasswordController,
              obscureText: true,
              hintText: "",
              labelText: "New Password",
              icon: CupertinoIcons.lock_circle,
            ),
            const SizedBox(height: 20),
            BorderTextField(
              controller: confirmPasswordController,
              obscureText: true,
              hintText: "",
              labelText: "Confirm Password",
              icon: CupertinoIcons.lock_circle,
            ),
            const SizedBox(height: 50),
            PrimaryButton(
              text: "Change Password",
              onPressed: () async {
                // Call the _updatePassword function here
                await _updatePassword();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    if (passwordController.text.isEmpty) {
      setState(() {
        requirement = "Please enter your current password";
      });
      return;
    } else if (newPasswordController.text.isEmpty) {
      setState(() {
        requirement = "Please enter your new password";
      });
      return;
    } else if (confirmPasswordController.text.isEmpty) {
      setState(() {
        requirement = "Please confirm your new password";
      });
      return;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      setState(() {
        requirement = "New password and confirm password do not match";
      });
      return;
    } else {
      try {
        await user?.updatePassword(newPasswordController.text);
        setState(() {
          requirement = "Password updated successfully";
        });

        // Show Cupertino Alert Dialog
        showCupertinoDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text("Success"),
              content:
                  const Text("Your password has been updated successfully."),
              actions: [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    context.pop(); // Navigate back to the previous screen
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        setState(() {
          requirement = "An error occurred. Please try again";
        });
      }
    }
  }
}
