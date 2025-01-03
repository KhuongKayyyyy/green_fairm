import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/res/weather_reposity.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart';
import 'package:green_fairm/presentation/bloc/weather/weather_bloc.dart';
import 'package:green_fairm/presentation/view/main/home/widget/check_our_ai_recommendation.dart';
import 'package:green_fairm/presentation/view/main/home/widget/field_water_monitor.dart';
import 'package:green_fairm/presentation/view/main/home/widget/my_fields_section.dart';
import 'package:green_fairm/presentation/view/main/home/widget/sensor_monitor.dart';
import 'package:green_fairm/presentation/view/main/home/widget/weather_report.dart';
import 'package:green_fairm/presentation/view/notification/notification_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FieldManagementBloc _fieldManagementBloc = FieldManagementBloc();
  final WeatherBloc _weatherBloc = WeatherBloc();
  final storage = const FlutterSecureStorage();
  var userId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeUserId();
    _fieldManagementBloc.add(FieldManagementGetByUserId(userId: userId));
    _weatherBloc.add(const WeatherGetByCity(city: 'Ho Chi Minh'));
  }

  Future<void> _initializeUserId() async {
    userId =
        (await const FlutterSecureStorage().read(key: AppSetting.userUid))!;
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWeatherReport(),
            _buildMyFieldsSection(),
            FieldWaterMonitor(),
            SensorMonitor(),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherReport() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: _weatherBloc,
      builder: (context, weatherState) {
        if (weatherState is WeatherLoading) {
          return Skeletonizer(
            enabled: true,
            enableSwitchAnimation: true,
            child: WeatherReport(
              weather: FakeData.fakeWeather,
            ),
          );
        } else if (weatherState is WeatherLoaded) {
          return WeatherReport(
            weather: weatherState.weather,
          );
        } else if (weatherState is WeatherError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Failed to load weather'),
          );
        }
        return Skeletonizer(
          enabled: true,
          enableSwitchAnimation: true,
          child: WeatherReport(
            weather: FakeData.fakeWeather,
          ),
        );
      },
    );
  }

  Widget _buildMyFieldsSection() {
    return BlocBuilder<FieldManagementBloc, FieldManagementState>(
      bloc: _fieldManagementBloc,
      builder: (context, fieldOfUserState) {
        if (fieldOfUserState is FieldManagementLoading) {
          return Skeletonizer(
            enabled: true,
            enableSwitchAnimation: true,
            child: MyFieldsSection(
              fields: FakeData.fakeFields,
            ),
          );
        } else if (fieldOfUserState is FieldManagementGetByUserIdSuccess) {
          return MyFieldsSection(
            fields: fieldOfUserState.fields,
          );
        } else if (fieldOfUserState is FieldManagementGetByUserIdError) {
          {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('Failed to load fields'),
            );
          }
        }
        return Skeletonizer(
          enabled: true,
          enableSwitchAnimation: true,
          child: MyFieldsSection(
            fields: FakeData.fakeFields,
          ),
        );
      },
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
