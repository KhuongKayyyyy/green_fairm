part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherGetByCity extends WeatherEvent {
  final String city;
  const WeatherGetByCity({required this.city});
}
