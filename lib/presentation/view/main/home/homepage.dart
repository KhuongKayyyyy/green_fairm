import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/data/res/machine_learning_repository.dart';
import 'package:green_fairm/data/res/user_repository.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart';
import 'package:green_fairm/presentation/bloc/weather/weather_bloc.dart';
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
  final WeatherBloc _weatherBloc = WeatherBloc();
  final storage = const FlutterSecureStorage();

  var userId = "";
  @override
  void initState() {
    super.initState();
    _initializeUserId();
    context
        .read<FieldManagementBloc>()
        .add(FieldManagementGetByUserId(userId: userId));
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
            TextButton(
                onPressed: () async {
                  String? userId = await storage.read(key: AppSetting.userUid);
                  Future<bool> result =
                      UserRepository().getUserEmailNotiFromServer(userId!);
                  result.then((value) {
                    print(value);
                  }).catchError((error) {
                    print("Error: $error");
                  });
                },
                child: const Text("Test")),
            _buildWeatherReport(),
            _buildMyFieldsSection(),
            const FieldWaterMonitor(),
            const SensorMonitor(),
            const SizedBox(height: 200),
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
      bloc: context.read<FieldManagementBloc>(),
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
          if (fieldOfUserState.fields.isEmpty) {
            return Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "Add your first field",
                style: AppTextStyle.defaultBold(color: Colors.white),
              )),
            );
          }
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
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return const NotificationPage();
        });
  }
}
