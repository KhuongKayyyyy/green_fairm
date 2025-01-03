import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';

class OnboardBackground extends StatelessWidget {
  final String image;
  const OnboardBackground({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: AppColors.secondaryColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
