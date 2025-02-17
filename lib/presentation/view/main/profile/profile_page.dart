import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/account_overview.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/account_setting_dialog.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/profile_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = FirebaseAuth.instance.currentUser!;

  void refresh() async {
    await user.reload();
    setState(() {
      user = FirebaseAuth.instance.currentUser!;
    });
  }

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
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.profileBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: ProfileHeader(
                needsRefresh: true,
                user: user, // Pass user to ProfileHeader
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountOverview(
                      onUpdate: () => refresh(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Text(
                "Profile",
                style: AppTextStyle.largeBold(),
              ),
            ),
            Positioned(
                top: 50,
                right: 20,
                child: InkWell(
                  onTap: () {
                    // Show account setting dialog
                    showDialog(
                      context: context,
                      builder: (context) => const AccountSettingDialog(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      CupertinoIcons.settings,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
