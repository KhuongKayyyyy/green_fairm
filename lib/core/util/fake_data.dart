import 'package:green_fairm/data/model/app_user.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/data/model/farm_notification.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/data/model/water_history.dart';
import 'package:green_fairm/data/model/weather_model.dart';

class FakeData {
  static AppUser user = AppUser(
    name: "Nguyen Dat Khuong",
    password: "1123",
    email: "nguyendatkhuong@gmail.com",
    avatarURL:
        "https://yt3.googleusercontent.com/oN0p3-PD3HUzn2KbMm4fVhvRrKtJhodGlwocI184BBSpybcQIphSeh3Z0i7WBgTq7e12yKxb=s900-c-k-c0x00ffffff-no-rj",
  );

  static final List<Field> fakeFields = [
    Field(
      id: "1",
      name: 'Field 1',
      status: 'Good',
      type: 'Rice',
      area: '1.5 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
    Field(
      id: "2",
      name: 'Field 2',
      status: 'Need water',
      type: 'Corn',
      area: '2.0 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
    Field(
      id: "3",
      name: 'Field 3',
      status: 'Good',
      type: 'Rice',
      area: '1.5 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
    Field(
      id: "4",
      name: 'Field 4',
      status: 'Need water',
      type: 'Corn',
      area: '2.0 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
    Field(
      id: "5",
      name: 'Field 1',
      status: 'Good',
      type: 'Rice',
      area: '1.5 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
    Field(
      id: "6",
      name: 'Field 2',
      status: 'Need water',
      type: 'Corn',
      area: '2.0 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
    Field(
      id: "7",
      name: 'Field 3',
      status: 'Good',
      type: 'Rice',
      area: '1.5 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
    Field(
      id: "8",
      name: 'Field 4',
      status: 'Need water',
      type: 'Corn',
      area: '2.0 ha',
      imageUrl:
          'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg',
      plantingDate: "17/11/2024",
      cropHealth: "Good",
      haverstTime: "in 1 month",
    ),
  ];

  static final List<FarmNotification> fakeNotifications = [
    FarmNotification(
        type: "Watering Plant",
        title: 'Filed 1 need water',
        description: 'Field 1 need water to grow',
        time: '9:00 AM',
        date: "15 December 2024"),
    FarmNotification(
        type: "Plant Health",
        title: 'Plant Health on Field 3',
        description: 'The health of Field 3 is good',
        time: '7:00 AM',
        date: "15 December 2024"),
    FarmNotification(
        type: "Heat Report",
        title: 'Heat Report of Field 2',
        description: 'The temperature of Field 2 is too high',
        time: '5:00 AM',
        date: "15 December 2024"),
  ];

  static final List<WaterHistory> fakeWaterHistories = [
    WaterHistory(
      id: "1",
      date: "Thursday, 12 August 2021",
      time: "9:00 AM",
      status: "Done",
    ),
    WaterHistory(
      id: "2",
      date: "Thursday, 12 August 2021",
      time: "9:00 AM",
      status: "Done",
    ),
    WaterHistory(
      id: "3",
      date: "Thursday, 12 August 2021",
      time: "9:00 AM",
      status: "Done",
    ),
    WaterHistory(
      id: "4",
      date: "Thursday, 12 August 2021",
      time: "9:00 AM",
      status: "Done",
    ),
    WaterHistory(
      id: "5",
      date: "Thursday, 12 August 2021",
      time: "9:00 AM",
      status: "Done",
    ),
  ];

  static WeatherModel fakeWeather = WeatherModel(
    cityName: "Ho Chi Minh",
    temperature: 30,
    description: "Cloudy",
    humidity: "80",
    windSpeed: 5,
    weatherIcon: "01d",
    visibility: "10000",
  );

  static final List<EnvironmentalData> fakeWeekChartData = [
    EnvironmentalData(
      date: "Mon",
      humidity: 68,
      light: 15,
      soilMoisture: 43,
      co2: 78,
      rain: 20,
    ),
    EnvironmentalData(
      date: "Tues",
      humidity: 70,
      light: 18,
      soilMoisture: 40,
      co2: 80,
      rain: 22,
    ),
    EnvironmentalData(
      date: "Wed",
      humidity: 72,
      light: 13,
      soilMoisture: 44,
      co2: 82,
      rain: 19,
    ),
    EnvironmentalData(
      date: "Thurs",
      humidity: 69,
      light: 16,
      soilMoisture: 42,
      co2: 79,
      rain: 21,
    ),
    EnvironmentalData(
      date: "Fri",
      humidity: 71,
      light: 11,
      soilMoisture: 45,
      co2: 81,
      rain: 23,
    ),
    EnvironmentalData(
      date: "Sat",
      humidity: 67,
      light: 17,
      soilMoisture: 39,
      co2: 77,
      rain: 20,
    ),
    EnvironmentalData(
      date: "Sun",
      humidity: 65,
      light: 12,
      soilMoisture: 40,
      co2: 75,
      rain: 18,
    ),
  ];

  static final List<EnvironmentalData> fakeDailyChartData = [
    EnvironmentalData(
      date: "12 AM",
      humidity: 65,
      light: 5,
      soilMoisture: 42,
      co2: 75,
      rain: 18,
    ),
    EnvironmentalData(
      date: "1 AM",
      humidity: 66,
      light: 5,
      soilMoisture: 43,
      co2: 76,
      rain: 18,
    ),
    EnvironmentalData(
      date: "2 AM",
      humidity: 66,
      light: 4,
      soilMoisture: 42,
      co2: 77,
      rain: 17,
    ),
    EnvironmentalData(
      date: "3 AM",
      humidity: 67,
      light: 4,
      soilMoisture: 41,
      co2: 76,
      rain: 16,
    ),
    EnvironmentalData(
      date: "4 AM",
      humidity: 68,
      light: 4,
      soilMoisture: 42,
      co2: 78,
      rain: 18,
    ),
    EnvironmentalData(
      date: "5 AM",
      humidity: 68,
      light: 5,
      soilMoisture: 43,
      co2: 78,
      rain: 19,
    ),
    EnvironmentalData(
      date: "6 AM",
      humidity: 68,
      light: 15,
      soilMoisture: 43,
      co2: 78,
      rain: 20,
    ),
    EnvironmentalData(
      date: "7 AM",
      humidity: 69,
      light: 20,
      soilMoisture: 42,
      co2: 79,
      rain: 21,
    ),
    EnvironmentalData(
      date: "8 AM",
      humidity: 70,
      light: 25,
      soilMoisture: 41,
      co2: 80,
      rain: 22,
    ),
    EnvironmentalData(
      date: "9 AM",
      humidity: 70,
      light: 18,
      soilMoisture: 40,
      co2: 80,
      rain: 22,
    ),
    EnvironmentalData(
      date: "10 AM",
      humidity: 71,
      light: 22,
      soilMoisture: 41,
      co2: 81,
      rain: 23,
    ),
    EnvironmentalData(
      date: "11 AM",
      humidity: 71,
      light: 24,
      soilMoisture: 42,
      co2: 81,
      rain: 22,
    ),
    EnvironmentalData(
      date: "12 PM",
      humidity: 72,
      light: 13,
      soilMoisture: 44,
      co2: 82,
      rain: 19,
    ),
    EnvironmentalData(
      date: "1 PM",
      humidity: 71,
      light: 14,
      soilMoisture: 43,
      co2: 81,
      rain: 20,
    ),
    EnvironmentalData(
      date: "2 PM",
      humidity: 70,
      light: 15,
      soilMoisture: 42,
      co2: 80,
      rain: 21,
    ),
    EnvironmentalData(
      date: "3 PM",
      humidity: 69,
      light: 16,
      soilMoisture: 42,
      co2: 79,
      rain: 21,
    ),
    EnvironmentalData(
      date: "4 PM",
      humidity: 69,
      light: 14,
      soilMoisture: 41,
      co2: 79,
      rain: 20,
    ),
    EnvironmentalData(
      date: "5 PM",
      humidity: 70,
      light: 13,
      soilMoisture: 42,
      co2: 80,
      rain: 22,
    ),
    EnvironmentalData(
      date: "6 PM",
      humidity: 71,
      light: 11,
      soilMoisture: 45,
      co2: 81,
      rain: 23,
    ),
    EnvironmentalData(
      date: "7 PM",
      humidity: 70,
      light: 8,
      soilMoisture: 44,
      co2: 80,
      rain: 21,
    ),
    EnvironmentalData(
      date: "8 PM",
      humidity: 68,
      light: 7,
      soilMoisture: 43,
      co2: 78,
      rain: 20,
    ),
    EnvironmentalData(
      date: "9 PM",
      humidity: 67,
      light: 6,
      soilMoisture: 39,
      co2: 77,
      rain: 20,
    ),
    EnvironmentalData(
      date: "10 PM",
      humidity: 66,
      light: 5,
      soilMoisture: 38,
      co2: 76,
      rain: 19,
    ),
    EnvironmentalData(
      date: "11 PM",
      humidity: 65,
      light: 5,
      soilMoisture: 37,
      co2: 75,
      rain: 18,
    ),
  ];

  static final List<StatisticData> fakeWeeklyTemperature = [
    StatisticData(date: "Mon", data: 30),
    StatisticData(date: "Tue", data: 32),
    StatisticData(date: "Wed", data: 31),
    StatisticData(date: "Thu", data: 33),
    StatisticData(date: "Fri", data: 30),
    StatisticData(date: "Sat", data: 34),
    StatisticData(date: "Sun", data: 32),
  ];

  static final List<StatisticData> fakeDailyTemperature = [
    StatisticData(date: "12 AM", data: 30),
    StatisticData(date: "1 AM", data: 31),
    StatisticData(date: "2 AM", data: 30),
    StatisticData(date: "3 AM", data: 32),
    StatisticData(date: "4 AM", data: 31),
    StatisticData(date: "5 AM", data: 33),
    StatisticData(date: "6 AM", data: 32),
    StatisticData(date: "7 AM", data: 34),
    StatisticData(date: "8 AM", data: 33),
    StatisticData(date: "9 AM", data: 35),
    StatisticData(date: "10 AM", data: 34),
    StatisticData(date: "11 AM", data: 36),
    StatisticData(date: "12 PM", data: 35),
    StatisticData(date: "1 PM", data: 37),
    StatisticData(date: "2 PM", data: 36),
    StatisticData(date: "3 PM", data: 38),
    StatisticData(date: "4 PM", data: 37),
    StatisticData(date: "5 PM", data: 39),
    StatisticData(date: "6 PM", data: 38),
    StatisticData(date: "7 PM", data: 40),
    StatisticData(date: "8 PM", data: 39),
    StatisticData(date: "9 PM", data: 41),
    StatisticData(date: "10 PM", data: 40),
    StatisticData(date: "11 PM", data: 42),
  ];
}
