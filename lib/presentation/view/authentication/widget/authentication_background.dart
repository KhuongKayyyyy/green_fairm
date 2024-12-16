import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';

class AuthenticationBackground extends StatelessWidget {
  const AuthenticationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          child: Transform.rotate(
            angle: -45 * 3.1415927 / 180, // 45 degrees to radians
            child: Image.asset(
              AppImage.plant1,
              scale: 2,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -50,
          child: Image.asset(
            AppImage.plant2,
            scale: 1.5,
          ),
        )
      ],
    );
  }
}
