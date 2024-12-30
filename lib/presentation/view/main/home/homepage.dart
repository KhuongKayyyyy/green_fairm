import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/res/field_repository.dart';
import 'package:green_fairm/presentation/view/main/home/widget/check_our_ai_recommendation.dart';
import 'package:green_fairm/presentation/view/main/home/widget/my_fields_section.dart';
import 'package:green_fairm/presentation/view/main/home/widget/weather_report.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FieldRepository _fieldRepository = FieldRepository();
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
              child: const Text("Go to setting")),
          TextButton(
              onPressed: () {
                // _fieldRepository.saveNewFieldToServer(
                //     name: "test",
                //     area: "test",
                //     userId: "6770eb3d650dc0712d7d1d1b");
              },
              child: const Text("test")),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
