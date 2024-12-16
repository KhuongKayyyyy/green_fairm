import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool agreePolicy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildRegisterBackground(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                children: [
                  _buildRegisterHeader(),
                  const SizedBox(height: 20),
                  _buildSignUpForm(),
                  _buildSignUpFooter()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Sign Up",
            style: AppTextStyle.largeBold(color: AppColor.secondaryColor)),
        Text(
          "Create new account",
          style: AppTextStyle.defaultBold(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Username/Email", style: AppTextStyle.defaultBold()),
        const SizedBox(
          height: 10,
        ),
        TextField(
          cursorColor: AppColor.secondaryColor,
          decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: const Icon(CupertinoIcons.person),
              prefixIconColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.focused)) {
                  return AppColor.secondaryColor;
                }
                return Colors.grey;
              }),
              fillColor: AppColor.primaryColor.withOpacity(0.2),
              filled: true,
              focusColor: AppColor.primaryColor.withOpacity(0.2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppColor.secondaryColor, width: 2))),
        ),
        const SizedBox(height: 20),
        Text("Password", style: AppTextStyle.defaultBold()),
        const SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: true,
          cursorColor: AppColor.secondaryColor,
          decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: const Icon(CupertinoIcons.lock),
              prefixIconColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.focused)) {
                  return AppColor.secondaryColor;
                }
                return Colors.grey;
              }),
              fillColor: AppColor.primaryColor.withOpacity(0.2),
              filled: true,
              focusColor: AppColor.primaryColor.withOpacity(0.2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppColor.secondaryColor, width: 2))),
        ),
        const SizedBox(height: 20),
        Text("Password confirm", style: AppTextStyle.defaultBold()),
        const SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: true,
          cursorColor: AppColor.secondaryColor,
          decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: const Icon(CupertinoIcons.lock),
              prefixIconColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.focused)) {
                  return AppColor.secondaryColor;
                }
                return Colors.grey;
              }),
              fillColor: AppColor.primaryColor.withOpacity(0.2),
              filled: true,
              focusColor: AppColor.primaryColor.withOpacity(0.2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppColor.secondaryColor, width: 2))),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
            text: "Sign Up",
            onPressed: () {
              context.pushNamed(Routes.otpVerification);
            }),
        const SizedBox(height: 10),
        Center(
          child: Text(
            "or sign up with",
            style: AppTextStyle.defaultBold(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButtonIcon(
                    icon: Icons.apple_outlined,
                    isGreen: true,
                    onPressed: () {}),
                ActionButtonIcon(
                    icon: Icons.facebook_rounded,
                    isGreen: true,
                    onPressed: () {}),
                ActionButtonIcon(
                    icon: Icons.g_mobiledata_rounded,
                    isGreen: true,
                    onPressed: () {}),
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildRegisterBackground() {
    return [
      Positioned(
          top: 30,
          left: -90,
          child: Hero(
            tag: "plant1",
            child: Transform.rotate(
              angle: 30 * 3.1415927 / 180, // 45 degrees to radians
              child: Image.asset(
                AppImage.plant1,
                scale: 2,
              ),
            ),
          )),
      Positioned(
        bottom: -10,
        left: -60,
        child: Hero(
          tag: "plant2",
          child: Image.asset(
            AppImage.plant2,
            scale: 1.5,
          ),
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

  Widget _buildSignUpFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(
              onPressed: () {
                final currentRoutes = GoRouter.of(context)
                    .routerDelegate
                    .currentConfiguration
                    .matches;

                // Check if the top-most route is "register"
                if (currentRoutes.any((route) =>
                    route.route is GoRoute &&
                    (route.route as GoRoute).name == Routes.login)) {
                  context.pop();
                } else {
                  context.pushNamed(Routes.login);
                }
              },
              child: Text(
                "Sign In",
                style: AppTextStyle.defaultBold(color: AppColor.primaryColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.grey,
                ),
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: agreePolicy,
                  onChanged: (bool? value) {
                    setState(() {
                      agreePolicy = value ?? false;
                    });
                  },
                  activeColor: AppColor.primaryColor,
                  checkColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Text.rich(
                TextSpan(
                  text: "By signing up you agree to our ",
                  children: [
                    TextSpan(
                      text: "Term of use",
                      style: TextStyle(color: AppColor.primaryColor),
                    ),
                    TextSpan(
                      text: " and ",
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(color: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
