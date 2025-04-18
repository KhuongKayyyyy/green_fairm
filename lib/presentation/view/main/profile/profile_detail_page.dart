import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/account_detail_information.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';

class ProfileDetailPage extends StatefulWidget {
  final VoidCallback onUpdate;
  const ProfileDetailPage({super.key, required this.onUpdate});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
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
                "Profile",
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
              child: SingleChildScrollView(
                child:
                    AccountDetailInformation(onUpdate: () => widget.onUpdate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
