import 'package:flutter/material.dart';
import 'package:green_fairm/presentation/view/setting/widget/setting_landing_body.dart';
import 'package:green_fairm/presentation/view/setting/widget/setting_landing_header.dart';

class SettingLandingPage extends StatelessWidget {
  const SettingLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SettingLandingHeader(),
          Padding(
            padding: EdgeInsets.all(15),
            child: SettingLandingBody(),
          )
        ],
      ),
    );
  }
}
