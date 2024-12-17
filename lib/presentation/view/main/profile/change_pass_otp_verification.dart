import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/authentication/widget/otp_verification_form.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/change_pass_successfully.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';

class ChangePassOtpVerification extends StatefulWidget {
  const ChangePassOtpVerification({super.key});

  @override
  State<ChangePassOtpVerification> createState() =>
      _ChangePassOtpVerificationState();
}

class _ChangePassOtpVerificationState extends State<ChangePassOtpVerification> {
  bool isChangeSuccess = false;
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
                "OTP Verification",
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
                )),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: isChangeSuccess
                  ? const ChangePassSuccessfully()
                  : OtpVerificationForm(onSuccessful: () {
                      setState(() {
                        isChangeSuccess = true;
                      });
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
