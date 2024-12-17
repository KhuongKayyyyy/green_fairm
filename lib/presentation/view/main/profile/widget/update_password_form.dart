import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/border_text_field.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class UpdatePasswordForm extends StatelessWidget {
  const UpdatePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BorderTextField(
                obscureText: true,
                hintText: FakeData.user.password,
                labelText: "Password",
                icon: CupertinoIcons.lock_circle),
            const SizedBox(
              height: 20,
            ),
            BorderTextField(
                obscureText: true,
                hintText: FakeData.user.password,
                labelText: "New Password",
                icon: CupertinoIcons.lock_circle),
            const SizedBox(
              height: 20,
            ),
            BorderTextField(
                obscureText: true,
                hintText: FakeData.user.password,
                labelText: "Password",
                icon: CupertinoIcons.lock_circle),
            const SizedBox(
              height: 50,
            ),
            PrimaryButton(
                text: "Continue",
                onPressed: () {
                  context.pushNamed(Routes.changePassOtp);
                })
          ],
        ),
      ),
    );
  }
}
