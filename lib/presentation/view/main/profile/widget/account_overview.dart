import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/res/user_repository.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/account_setting_section.dart';

class AccountOverview extends StatefulWidget {
  const AccountOverview({super.key});

  @override
  State<AccountOverview> createState() => _AccountOverviewState();
}

class _AccountOverviewState extends State<AccountOverview> {
  User user = FirebaseAuth.instance.currentUser!;

  bool isSignedInByGoogle = false;
  @override
  void initState() {
    super.initState();
    checkGoogleSignIn();
  }

  void checkGoogleSignIn() {
    for (UserInfo provider in user.providerData) {
      if (provider.providerId == "google.com") {
        setState(() {
          isSignedInByGoogle = true;
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Overview",
              style: AppTextStyle.defaultBold(),
            ),
            const SizedBox(height: 20),
            AccountSettingSection(
                backgroundColor: const Color(0xff65B6F1).withOpacity(0.4),
                icon: const Icon(
                  CupertinoIcons.person,
                  color: Color(
                    0xff65B6F1,
                  ),
                  size: 30,
                ),
                settingType: "My Profile",
                onTap: () => context.pushNamed(Routes.profileDetail)),
            const SizedBox(height: 20),
            if (isSignedInByGoogle == false)
              Column(
                children: [
                  AccountSettingSection(
                      onTap: () => context.pushNamed(Routes.updatePassword),
                      backgroundColor: const Color(0xffF99B77).withOpacity(0.4),
                      icon: const Icon(
                        CupertinoIcons.lock,
                        color: Color(
                          0xffF99B77,
                        ),
                        size: 30,
                      ),
                      settingType: "Change Password"),
                  const SizedBox(height: 20),
                ],
              ),
            AccountSettingSection(
                onTap: () {
                  context.pushNamed(Routes.addNewField);
                },
                backgroundColor: AppColors.primaryColor.withOpacity(0.4),
                icon: const Icon(
                  CupertinoIcons.tree,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
                settingType: "Set up more field"),
            const SizedBox(height: 20),
            AccountSettingSection(
                onTap: () async {
                  // ignore: use_build_context_synchronously
                  context.goNamed(Routes.authenticate_landing);
                  UserRepository().signOut();
                },
                backgroundColor: const Color(0xffF84141).withOpacity(0.4),
                icon: const Icon(
                  CupertinoIcons.square_arrow_left,
                  color: Color(
                    0xffF84141,
                  ),
                  size: 30,
                ),
                settingType: "Log out"),
          ],
        ),
      ),
    );
  }
}
