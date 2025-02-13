import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/res/user_repository.dart';
import 'package:green_fairm/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/account_setting_section.dart';

class AccountOverview extends StatefulWidget {
  final VoidCallback onUpdate;
  const AccountOverview({super.key, required this.onUpdate});

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
                onTap: () => context.pushNamed(Routes.profileDetail,
                    extra: widget.onUpdate)),
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
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: context.read<AuthenticationBloc>(),
              builder: (context, deleteState) {
                if (deleteState is AuthenticationLoading) {
                  EasyLoading.show(status: "Deleting account");
                } else if (deleteState is AuthenticationDeleteAccountSuccess) {
                  EasyLoading.showSuccess("Account deleted");
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.pop();
                    context.goNamed(Routes.authenticate_landing);
                  });
                } else if (deleteState is AuthenticationFailure) {
                  EasyLoading.showError(deleteState.message);
                }
                return AccountSettingSection(
                    onTap: () async {
                      // ignore: use_build_context_synchronously
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text("Delete Account"),
                              content: const Text(
                                  "Are you sure you want to delete your account?"),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text("Delete"),
                                  onPressed: () async {
                                    context.read<AuthenticationBloc>().add(
                                        AuthenticationEventDeleteAccount());
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    backgroundColor: const Color(0xffF84141).withOpacity(0.4),
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Color(
                        0xffF84141,
                      ),
                      size: 30,
                    ),
                    settingType: "Delete Account");
              },
            ),
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
