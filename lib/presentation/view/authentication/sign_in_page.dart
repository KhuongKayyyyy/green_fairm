import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/view/authentication/widget/authentication_background.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool keepSignIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildSignInBackground(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                children: [
                  _buildSignInHeader(),
                  const SizedBox(height: 50),
                  _buildSignInForm(),
                  _buildSignInFooter()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                final currentRoutes = GoRouter.of(context)
                    .routerDelegate
                    .currentConfiguration
                    .matches;

                // Check if the top-most route is "register"
                if (currentRoutes.any((route) =>
                    route.route is GoRoute &&
                    (route.route as GoRoute).name == Routes.register)) {
                  context.pop();
                } else {
                  context.pushNamed(Routes.register);
                }
              },
              child: Text(
                "Sign Up",
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
                  value: keepSignIn,
                  onChanged: (bool? value) {
                    setState(() {
                      keepSignIn = value ?? false;
                    });
                  },
                  activeColor: AppColor.primaryColor,
                  checkColor: Colors.white,
                ),
              ),
            ),
            const Text("Keep me signed in"),
          ],
        )
      ],
    );
  }

  Widget _buildSignInForm() {
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
        Align(
          alignment: Alignment.centerRight,
          child: Text("Forgot Password?",
              style: AppTextStyle.defaultBold(color: Colors.grey),
              textAlign: TextAlign.end),
        ),
        const SizedBox(height: 20),
        PrimaryButton(text: "Sign In", onPressed: () {}),
        const SizedBox(height: 10),
        Center(
          child: Text(
            "or sign in with",
            style: AppTextStyle.defaultBold(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            print(GoRouter.of(context).routerDelegate.currentConfiguration);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.facebook_rounded,
                  color: AppColor.secondaryColor,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Text(
                  "Login with Google",
                  style:
                      AppTextStyle.mediumBold(color: AppColor.secondaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSignInBackground() {
    return [
      Positioned(
        top: 60,
        left: 15,
        child: ActionButtonIcon(
          icon: CupertinoIcons.chevron_left,
          isGreen: true,
          onPressed: () => context.pop(),
        ),
      ),
      Positioned(
        top: 0,
        right: -50,
        child: Hero(
          tag: "plant1",
          child: Transform.rotate(
            angle: -45 * 3.1415927 / 180, // 45 degrees to radians
            child: Image.asset(
              AppImage.plant1,
              scale: 2,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: -50,
        child: Hero(
          tag: "plant2",
          child: Image.asset(
            AppImage.plant2,
            scale: 1.5,
          ),
        ),
      )
    ];
  }

  Widget _buildSignInHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Welcome Back",
            style: AppTextStyle.largeBold(color: AppColor.secondaryColor)),
        Text(
          "Sign in to continue",
          style: AppTextStyle.defaultBold(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
