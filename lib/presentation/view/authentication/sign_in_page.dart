import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/bloc/login/login_bloc.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController =
      TextEditingController(text: "zzkhngzz@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "11231123");
  bool keepSignIn = false;
  // late final LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    // loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
                      BlocListener<LoginBloc, LoginState>(
                        bloc: context.read<LoginBloc>(),
                        listener: (context, loginState) {
                          if (loginState is LoginLoading) {
                            EasyLoading.show(status: 'Logging in...');
                          } else {
                            EasyLoading.dismiss();
                          }

                          if (loginState is LoginSuccess) {
                            context
                                .go(Routes.home); // Navigate to home on success
                          } else if (loginState is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(loginState.errorMessage),
                              ),
                            );
                          }
                        },
                        child: _buildSignInForm(),
                      ),
                      _buildSignInFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Username/Email",
          hintText: "Email",
          controller: emailController,
          icon: CupertinoIcons.person,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Password",
          hintText: "Password",
          controller: passwordController,
          icon: CupertinoIcons.lock,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              context.pushNamed(Routes.forgotPassword);
            },
            child: Text(
              "Forgot Password?",
              style: AppTextStyle.defaultBold(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          text: "Sign In",
          onPressed: () {
            context.read<LoginBloc>().add(
                  LoginEventWithEmailAndPasswordPressed(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
          },
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            "or sign in with",
            style: AppTextStyle.defaultBold(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        _buildSocialSignInButton(),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.defaultBold()),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: AppColors.secondaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            prefixIconColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return AppColors.secondaryColor;
              }
              return Colors.grey;
            }),
            fillColor: AppColors.primaryColor.withOpacity(0.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.secondaryColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
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
                style: AppTextStyle.defaultBold(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              value: keepSignIn,
              onChanged: (value) => setState(() => keepSignIn = value ?? false),
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
            ),
            const Text("Keep me signed in"),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialSignInButton() {
    return InkWell(
      onTap: () {
        context.read<LoginBloc>().add(const LoginEventWithGooglePressed());
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
              color: AppColors.secondaryColor,
              size: 25,
            ),
            const SizedBox(width: 10),
            Text(
              "Login with Google",
              style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
            ),
          ],
        ),
      ),
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

  Widget _buildSignInHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Welcome Back",
            style: AppTextStyle.largeBold(color: AppColors.secondaryColor)),
        Text(
          "Sign in to continue",
          style: AppTextStyle.defaultBold(color: Colors.grey),
        ),
      ],
    );
  }
}
