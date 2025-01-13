import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:green_fairm/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/border_text_field.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/user_avatar.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class AccountDetailInformation extends StatefulWidget {
  final VoidCallback onUpdate;
  const AccountDetailInformation({super.key, required this.onUpdate});

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
    super.initState();
    firstNameController = TextEditingController(text: getFirstName());
    lastNameController = TextEditingController(text: getLastName());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Hero(tag: "avatar", child: UserAvatar()),
                BorderTextField(
                  controller: firstNameController,
                  hintText: "",
                  labelText: "First Name",
                  suffixIcon: CupertinoIcons.person,
                ),
                const SizedBox(height: 5),
                BorderTextField(
                  controller: lastNameController,
                  hintText: "",
                  labelText: "Last Name",
                  suffixIcon: CupertinoIcons.person,
                ),
                const SizedBox(height: 5),
                BorderTextField(
                  hintText: user.email!,
                  labelText: "Email Address",
                  suffixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 5),
                BorderTextField(
                  hintText: "+84 0909090909",
                  labelText: "Phone Number",
                  suffixIcon: CupertinoIcons.phone,
                ),
                const SizedBox(height: 30),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationUpdateProfileSuccess) {
                      EasyLoading.showSuccess("Your changes have been saved.");
                      widget.onUpdate();
                      // showCupertinoDialog(
                      //   context: context,
                      //   builder: (context) => CupertinoAlertDialog(
                      //     title: const Text("Success"),
                      //     content: const Text("Your changes have been saved."),
                      //     actions: [
                      //       CupertinoDialogAction(
                      //         child: const Text("OK"),
                      //         onPressed: () {
                      //           context.pop();
                      //           context.pop();
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // );
                    } else if (state is AuthenticationFailure) {
                      EasyLoading.showError(state.message);
                    } else if (state is AuthenticationLoading) {
                      EasyLoading.show(status: "Saving changes...");
                    }
                  },
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(
                              AuthenticationEventUpdateUserName(
                                  "${firstNameController.text} ${lastNameController.text}"));
                        },
                        text: "Save changes",
                      );
                    },
                  ),
                ),
              ],
            ),
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
