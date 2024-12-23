import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/util/fake_data.dart';
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
                hintText: getFirstName(),
                labelText: "First Name",
                icon: CupertinoIcons.person,
              ),
              const SizedBox(
                height: 5,
              ),
              BorderTextField(
                hintText: getLastName(),
                labelText: "Last Name",
                icon: CupertinoIcons.person,
              ),
              const SizedBox(
                height: 5,
              ),
              BorderTextField(
                hintText: user.email!,
                labelText: "Email Address",
                icon: Icons.email_outlined,
              ),
              const SizedBox(
                height: 5,
              ),
              const BorderTextField(
                hintText: "+84 0909090909",
                labelText: "Phone Number",
                icon: CupertinoIcons.phone,
              ),
              const SizedBox(
                height: 5,
              ),
              // const Spacer(),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                onPressed: () {},
                text: "Save changes",
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFirstName() {
    return user.displayName!.split(' ').first;
  }

  String getLastName() {
    return user.displayName!.split(' ').last;
  }
}
