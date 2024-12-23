import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/bloc/register/register_bloc.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class SetupInformationPage extends StatefulWidget {
  const SetupInformationPage({super.key});

  @override
  State<SetupInformationPage> createState() => _SetupInformationPageState();
}

class _SetupInformationPageState extends State<SetupInformationPage> {
  // Declare TextEditingController instances for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late final RegisterBloc registerBloc;

  @override
  void initState() {
    super.initState();
    registerBloc = RegisterBloc();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildSetupBackground(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                children: [
                  _buildSetupHeader(),
                  const SizedBox(height: 100),
                  _buildSetupForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetupHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Set Up Information",
            style: AppTextStyle.largeBold(color: AppColor.secondaryColor)),
        Text("Please provide your details",
            style: AppTextStyle.defaultBold(color: Colors.grey),
            textAlign: TextAlign.center),
      ],
    );
  }

  // Reusable method for TextField widget
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.defaultBold()),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: AppColor.secondaryColor,
          decoration: InputDecoration(
            hintText: label,
            prefixIcon: Icon(icon),
            prefixIconColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return AppColor.secondaryColor;
              }
              return Colors.grey;
            }),
            fillColor: AppColor.primaryColor.withOpacity(0.2),
            filled: true,
            focusColor: AppColor.primaryColor.withOpacity(0.2),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColor.secondaryColor, width: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildSetupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
            label: "First Name",
            controller: firstNameController,
            icon: CupertinoIcons.person),
        const SizedBox(height: 20),
        _buildTextField(
            label: "Last Name",
            controller: lastNameController,
            icon: CupertinoIcons.person),
        const SizedBox(height: 20),
        _buildTextField(
            label: "Phone",
            controller: phoneController,
            icon: CupertinoIcons.phone),
        const SizedBox(height: 150),
        PrimaryButton(
          text: "Next",
          onPressed: () async {
            if (firstNameController.text.isEmpty ||
                lastNameController.text.isEmpty ||
                phoneController.text.isEmpty) {
              EasyLoading.showError('Please fill in all fields');
              return;
            }

            EasyLoading.show(status: 'Updating...');
            try {
              User? user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                // Update the display name
                await user.updateDisplayName(
                    '${firstNameController.text} ${lastNameController.text}');

                // Assuming you already have a phone verification process (verificationId and smsCode)
                // Replace '' with the actual verification ID and smsCode you received during phone authentication
                // await user.updatePhoneNumber(PhoneAuthProvider.credential(
                //   verificationId:
                //       'your_verification_id', // Set the actual verification ID here
                //   smsCode: phoneController.text, // SMS code entered by the user
                // ));

                EasyLoading.showSuccess('Information updated successfully');
                // ignore: use_build_context_synchronously
                context.go(Routes.home); // Navigate to the home page
              } else {
                EasyLoading.showError('No user is signed in');
              }
            } catch (e) {
              EasyLoading.showError('Failed to update information: $e');
              print('Failed to update information: $e');
            }
          },
        )
      ],
    );
  }

  List<Widget> _buildSetupBackground() {
    return [
      Positioned(
        top: 30,
        right: -90,
        child: Hero(
          tag: "plant1",
          child: Transform.rotate(
            angle: -45 * 3.1415927 / 180,
            child: Image.asset(AppImage.plant1, scale: 2),
          ),
        ),
      ),
      Positioned(
        bottom: -10,
        left: -60,
        child: Hero(
          tag: "plant2",
          child: Image.asset(AppImage.plant2, scale: 1.5),
        ),
      ),
    ];
  }
}
