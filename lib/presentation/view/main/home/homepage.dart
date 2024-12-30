import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/view/main/home/widget/check_our_ai_recommendation.dart';
import 'package:green_fairm/presentation/view/main/home/widget/my_fields_section.dart';
import 'package:green_fairm/presentation/view/main/home/widget/weather_report.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WeatherReport(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CheckOurAiRecommendation(),
          ),
          const MyFieldsSection(),
          TextButton(
              onPressed: () {
                context.pushNamed(Routes.settingLanding);
              },
              child: Text("Go to setting")),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser?.sendEmailVerification();
              },
              child: Text("Send Verification")),
        ],
      ),
    );
  }
}
