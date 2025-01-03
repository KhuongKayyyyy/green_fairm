part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  const WeatherLoaded({required this.weather});

  @override
  List<Object> get props => [weather];
}

final class WeatherError extends WeatherState {
  final String message;
  const WeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
