import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class OtpVerificationForm extends StatelessWidget {
  final VoidCallback onSuccessful;
  const OtpVerificationForm({super.key, required this.onSuccessful});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                textAlign: TextAlign.center,
                "OTP has been sent to ${FakeData.user.email}",
                style: AppTextStyle.mediumBold(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: AppTextStyle.mediumBold(),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 100),
            StreamBuilder<int>(
              stream: Stream.periodic(const Duration(seconds: 1), (i) => 30 - i)
                  .take(31),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final seconds = snapshot.data!;
                  final minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
                  final secondsStr = (seconds % 60).toString().padLeft(2, '0');
                  return Text(
                    '$minutesStr:$secondsStr',
                    style: AppTextStyle.mediumBold(color: AppColor.grey),
                  );
                } else {
                  return Text(
                    '00:30',
                    style: AppTextStyle.mediumBold(color: AppColor.grey),
                  );
                }
              },
            ),
            InkWell(
              child: Text("Resend OTP",
                  style: AppTextStyle.mediumBold(color: Colors.grey)),
            ),
            const SizedBox(height: 100),
            PrimaryButton(text: "Confirm", onPressed: onSuccessful)
          ],
        ),
      ),
    );
  }
}
