import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/data/res/user_repository.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class AccountSettingDialog extends StatefulWidget {
  const AccountSettingDialog({super.key});

  @override
  State<AccountSettingDialog> createState() => _AccountSettingDialogState();
}

class _AccountSettingDialogState extends State<AccountSettingDialog> {
  bool _isEmailReport = true;
  String? userId = "";
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    userId = await storage.read(key: AppSetting.userUid);
    if (userId != null) {
      _isEmailReport =
          await UserRepository().getUserEmailNotiFromServer(userId!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Apply border radius here
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Ensure clipping
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.white,
          child: Column(
            children: [
              const Text(
                'Account Setting',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Email Reports',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                    value: _isEmailReport,
                    onChanged: (value) {
                      setState(() {
                        _isEmailReport = value;
                        UserRepository()
                            .updateEmailNotification(value, userId!);
                      });
                    },
                    activeColor: AppColors.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Dark Mode (Coming Soon)',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Switch.adaptive(
                    value: false,
                    onChanged: null, // Disable the switch
                    activeColor: AppColors.primaryColor,
                  ),
                ],
              ),
              const Spacer(),
              PrimaryButton(
                  isReverse: true,
                  text: "Done",
                  onPressed: () {
                    context.pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
