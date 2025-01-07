import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';

// ignore: must_be_immutable
class CheckOurAiRecommendation extends StatelessWidget {
  String? message;
  IconData? icon;
  Function()? onTap;
  CheckOurAiRecommendation({super.key, this.message, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                child: Icon(icon ?? Icons.lightbulb_outline,
                    color: AppColors.secondaryColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                    message ?? "Check our AI recommendation for your farm",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const Icon(CupertinoIcons.arrow_right, color: Colors.white),
            ],
          )),
    );
  }
}
