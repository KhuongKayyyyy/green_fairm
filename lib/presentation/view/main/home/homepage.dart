import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/res/field_repository.dart';
import 'package:green_fairm/presentation/view/main/home/widget/check_our_ai_recommendation.dart';
import 'package:green_fairm/presentation/view/main/home/widget/field_water_monitor.dart';
import 'package:green_fairm/presentation/view/main/home/widget/my_fields_section.dart';
import 'package:green_fairm/presentation/view/main/home/widget/sensor_monitor.dart';
import 'package:green_fairm/presentation/view/main/home/widget/weather_report.dart';
import 'package:green_fairm/presentation/view/notification/notification_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FieldRepository _fieldRepository = FieldRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homepage',
          style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: InkWell(
              onTap: () {
                _showNotificationPage(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            WeatherReport(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: CheckOurAiRecommendation(),
            ),
            MyFieldsSection(),
            FieldWaterMonitor(),
            SensorMonitor(),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  void _showNotificationPage(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(16),
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return const NotificationPage();
        });
  }
}
