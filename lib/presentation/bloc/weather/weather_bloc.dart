import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:green_fairm/data/model/weather_model.dart';
import 'package:green_fairm/data/res/weather_reposity.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherGetByCity>(_onGetByCity);
  }

  Future<void> _onGetByCity(
      WeatherGetByCity event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await WeatherReposity.fetchWeather(event.city);
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      emit(const WeatherError(message: 'An unknown error occurred'));
    }
  }
}
