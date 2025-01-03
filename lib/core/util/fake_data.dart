import 'package:green_fairm/data/model/app_user.dart';
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
}
