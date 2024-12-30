import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/border_text_field.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/user_avatar.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class AccountDetailInformation extends StatefulWidget {
  const AccountDetailInformation({super.key});

  @override
  State<AccountDetailInformation> createState() =>
      _AccountDetailInformationState();
}

class _AccountDetailInformationState extends State<AccountDetailInformation> {
  final User user = FirebaseAuth.instance.currentUser!;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController(text: getFirstName());
    lastNameController = TextEditingController(text: getLastName());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Hero(tag: "avatar", child: UserAvatar()),
              BorderTextField(
                controller: firstNameController,
                hintText: "",
                labelText: "First Name",
                suffixIcon: CupertinoIcons.person,
              ),
              const SizedBox(
                height: 5,
              ),
              BorderTextField(
                controller: lastNameController,
                hintText: "",
                labelText: "Last Name",
                suffixIcon: CupertinoIcons.person,
              ),
              const SizedBox(
                height: 5,
              ),
              BorderTextField(
                hintText: user.email!,
                labelText: "Email Address",
                suffixIcon: Icons.email_outlined,
              ),
              const SizedBox(
                height: 5,
              ),
              BorderTextField(
                hintText: "+84 0909090909",
                labelText: "Phone Number",
                suffixIcon: CupertinoIcons.phone,
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                onPressed: () async {
                  EasyLoading.show(status: "Saving changes...");

                  try {
                    // Update user display name
                    await user.updateDisplayName(
                        "${firstNameController.text} ${lastNameController.text}");

                    // Reload user data to ensure the updates are applied
                    await user.reload();

                    // Dismiss the loading indicator
                    EasyLoading.dismiss();

                    // Show success dialog
                    showCupertinoDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Success"),
                        content: const Text("Your changes have been saved."),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("OK"),
                            onPressed: () {
                              context.pop();
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    );
                  } catch (error) {
                    EasyLoading.dismiss();
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Error"),
                        content: Text(error.toString()),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("OK"),
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                text: "Save changes",
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFirstName() {
    final displayName = user.displayName ?? "";
    final nameParts = displayName.split(' ');
    return nameParts.isNotEmpty ? nameParts.first : "";
  }

  String getLastName() {
    final displayName = user.displayName ?? "";
    final nameParts = displayName.split(' ');

    // If the name has exactly two words, return an empty string as the last name
    return nameParts.length > 2 ? nameParts.sublist(1).join(' ') : "";
  }
}
