import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:green_fairm/core/constant/sensor_type.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/data/res/environmental_data_repository.dart';
import 'package:green_fairm/data/res/machine_learning_repository.dart';

part 'ml_event.dart';
part 'ml_state.dart';

class MlBloc extends Bloc<MlEvent, MlState> {
  final MachineLearningRepository _machineLearningRepository =
      MachineLearningRepository();
  final EnvironmentalDataRepository _environmentalDataRepository =
      EnvironmentalDataRepository();
  MlBloc() : super(MlInitial()) {
    on<MlEvent>((event, emit) {});

    on<MlHealthPredictionRequested>(_onHealthPredictionRequested);
    on<MlWaterNeedRequested>(_onWaterNeedRequested);
  }

  Future<EnvironmentalData> _getEnvironmentalData(
      String date, String fieldId, bool isReversed) async {
    final humidityData = await _environmentalDataRepository.getDailyStatistic(
        date: date, fieldId: fieldId, type: SensorType.humidity);
    final soilMoistureData =
        await _environmentalDataRepository.getDailyStatistic(
            date: date, fieldId: fieldId, type: SensorType.soilMoisture);
    final lightData = await _environmentalDataRepository.getDailyStatistic(
        date: date, fieldId: fieldId, type: SensorType.light);
    final co2Data = await _environmentalDataRepository.getDailyStatistic(
        date: date, fieldId: fieldId, type: SensorType.gasVolume);
    final rainVolume = await _environmentalDataRepository.getDailyStatistic(
        date: date, fieldId: fieldId, type: SensorType.rainVolume);
    final humidityAvg =
        Helper.calculateAverage(humidityData.map((data) => data.data).toList());
    final soilMoistureAvg = Helper.calculateAverage(
        soilMoistureData.map((data) => data.data).toList());
    final lightAvg =
        Helper.calculateAverage(lightData.map((data) => data.data).toList());
    final co2Avg =
        Helper.calculateAverage(co2Data.map((data) => data.data).toList());
    final rainVolumeAvg =
        Helper.calculateAverage(rainVolume.map((data) => data.data).toList());
    return EnvironmentalData(
        humidity: humidityAvg,
        light: lightAvg * 4095 / 100,
        soilMoisture: isReversed
            ? 4095 - (soilMoistureAvg * 4095 / 100)
            : soilMoistureAvg * 4095 / 100,
        rain: rainVolumeAvg * 4095 / 100,
        co2: co2Avg * 4095 / 100);
  }

  Future<void> _onHealthPredictionRequested(
    MlHealthPredictionRequested event,
    Emitter<MlState> emit,
  ) async {
    emit(MlLoading());
    try {
      final temperatureData =
          await _environmentalDataRepository.getDailyStatistic(
              date: event.date,
              fieldId: event.fieldId,
              type: SensorType.temperature);
      final temperatureAvg = Helper.calculateAverage(
          temperatureData.map((data) => data.data).toList());
      final environmentalData =
          await _getEnvironmentalData(event.date, event.fieldId, true);
      if (temperatureAvg == 0 &&
          environmentalData.humidity == 0 &&
          environmentalData.soilMoisture == 4095 &&
          environmentalData.light == 0 &&
          environmentalData.co2 == 0 &&
          environmentalData.rain == 0) {
        emit(const MlHealthPredictionFailure(
            errorMessage: 'Failed to fetch health prediction data.'));
        return;
      }
      final healthPrediction =
          await _machineLearningRepository.getPlantHealthPrediction(
              environmentalData, temperatureAvg.toDouble());
      emit(MlHealthPredictionSuccess(healthPredictions: healthPrediction));
    } catch (e) {
      emit(const MlHealthPredictionFailure(
          errorMessage: 'Failed to fetch health prediction data.'));
    }
  }

  Future<void> _onWaterNeedRequested(
    MlWaterNeedRequested event,
    Emitter<MlState> emit,
  ) async {
    emit(MlLoading());
    try {
      final temperatureData =
          await _environmentalDataRepository.getDailyStatistic(
              date: event.date,
              fieldId: event.fieldId,
              type: SensorType.temperature);
      final humidityData = await _environmentalDataRepository.getDailyStatistic(
          date: event.date, fieldId: event.fieldId, type: SensorType.humidity);
      final soilMoistureData =
          await _environmentalDataRepository.getDailyStatistic(
              date: event.date,
              fieldId: event.fieldId,
              type: SensorType.soilMoisture);
      final lightData = await _environmentalDataRepository.getDailyStatistic(
          date: event.date, fieldId: event.fieldId, type: SensorType.light);
      final co2Data = await _environmentalDataRepository.getDailyStatistic(
          date: event.date, fieldId: event.fieldId, type: SensorType.gasVolume);
      final rainVolume = await _environmentalDataRepository.getDailyStatistic(
          date: event.date,
          fieldId: event.fieldId,
          type: SensorType.rainVolume);
      final environmentalData = EnvironmentalData(
          humidity: humidityData.last.data,
          light: lightData.last.data,
          soilMoisture: soilMoistureData.last.data,
          rain: rainVolume.last.data,
          co2: co2Data.last.data);
      if (temperatureData.last.data == 0 &&
          environmentalData.humidity == 0 &&
          environmentalData.soilMoisture == 0 &&
          environmentalData.light == 0 &&
          environmentalData.co2 == 0 &&
          environmentalData.rain == 0) {
        emit(const MlWaterNeedFailure(
            errorMessage: 'Failed to fetch water need prediction data.'));
        return;
      }
      final waterNeed = await _machineLearningRepository.getWaterNeedPrediction(
          environmentalData, temperatureData.last.data.toDouble());
      emit(MlWaterNeedSuccess(waterNeed: waterNeed));
    } catch (e) {
      emit(const MlWaterNeedFailure(
          errorMessage: 'Failed to fetch water need prediction data.'));
    }
  }
}
