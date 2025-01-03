import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';

class CheckOurAiRecommendation extends StatelessWidget {
  const CheckOurAiRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppColors.primaryColor, AppColors.secondaryColor]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.lightbulb_outline,
                  color: AppColors.secondaryColor),
            ),
            const SizedBox(width: 10),
            const Flexible(
              child: Text("Check our AI recommendation for your farm",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const Icon(CupertinoIcons.arrow_right, color: Colors.white),
          ],
        ));
  }
}
