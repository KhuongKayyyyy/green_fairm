import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:green_fairm/core/constant/sensor_type.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/data/res/environmental_data_repository.dart';

part 'field_analysis_event.dart';
part 'field_analysis_state.dart';

class FieldAnalysisBloc extends Bloc<FieldAnalysisEvent, FieldAnalysisState> {
  final EnvironmentalDataRepository _environmentalDataRepository =
      EnvironmentalDataRepository();

  FieldAnalysisBloc() : super(FieldAnalysisInitial()) {
    on<FieldAnalysisDailyAverageDataRequested>(_onDailyAverageDataRequested);
    on<FieldAnalysisDailyDataRequested>(_onDailyDataRequested);
    on<FieldAnalysisWeeklyDataRequested>(_onWeeklyDataRequested);
    on<FieldAnaylysisDailyFullDataRequested>(_onDailyFullDataRequested);
    on<FieldAnaylysisWeeklyFullDataRequested>(_onWeeklyFullDataRequested);
  }

  Future<void> _onDailyAverageDataRequested(
    FieldAnalysisDailyAverageDataRequested event,
    Emitter<FieldAnalysisState> emit,
  ) async {
    emit(FieldAnalysisLoading());
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

      final temperatureAvg = Helper.calculateAverage(
          temperatureData.map((data) => data.data).toList());
      final humidityAvg = Helper.calculateAverage(
          humidityData.map((data) => data.data).toList());
      final soilMoistureAvg = Helper.calculateAverage(
          soilMoistureData.map((data) => data.data).toList());

      emit(FieldAnalysisDailyAverageDataSuccess(
        temperatureAverage: temperatureAvg.toDouble(),
        humidityAverage: humidityAvg.toDouble(),
        soilMoistureAverage: soilMoistureAvg.toDouble(),
      ));
    } catch (e) {
      emit(const FieldAnalysisDailyAverageDataFailure(
          errorMessage: 'Failed to fetch daily average data.'));
    }
  }

  Future<void> _onDailyDataRequested(
    FieldAnalysisDailyDataRequested event,
    Emitter<FieldAnalysisState> emit,
  ) async {
    emit(FieldAnalysisLoading());
    try {
      final data = await _environmentalDataRepository.getDailyStatistic(
          date: event.date, fieldId: event.fieldId, type: event.type);

      emit(FieldAnalysisDailyDataSuccess(data: data));
    } catch (e) {
      emit(const FieldAnalysisDailyDataFailure(
          errorMessage: 'Failed to fetch daily data.'));
    }
  }

  Future<void> _onWeeklyDataRequested(
    FieldAnalysisWeeklyDataRequested event,
    Emitter<FieldAnalysisState> emit,
  ) async {
    emit(FieldAnalysisLoading());
    try {
      final data = await _environmentalDataRepository.getWeeklyStatistic(
          date: event.date, fieldId: event.fieldId, type: event.type);

      emit(FieldAnalysisWeeklyDataSuccess(data: data));
    } catch (e) {
      emit(const FieldAnalysisWeeklyDataFailure(
          errorMessage: 'Failed to fetch weekly data.'));
    }
  }

  Future<void> _onDailyFullDataRequested(
    FieldAnaylysisDailyFullDataRequested event,
    Emitter<FieldAnalysisState> emit,
  ) async {
    emit(FieldAnalysisLoading());
    try {
      // Fetching data for each sensor type as lists
      final List<StatisticData> humidityData =
          await _environmentalDataRepository.getDailyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.humidity,
      );

      final List<StatisticData> soilMoistureData =
          await _environmentalDataRepository.getDailyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.soilMoisture,
      );

      final List<StatisticData> lightData =
          await _environmentalDataRepository.getDailyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.light,
      );

      final List<StatisticData> co2Data =
          await _environmentalDataRepository.getDailyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.gasVolume,
      );

      final List<StatisticData> rainData =
          await _environmentalDataRepository.getDailyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.rainVolume,
      );

      // Validate all lists have the same length
      final int listLength = humidityData.length;
      if (soilMoistureData.length != listLength ||
          lightData.length != listLength ||
          co2Data.length != listLength ||
          rainData.length != listLength) {
        throw Exception("Mismatched data lengths between sensor types.");
      }

      // Map the data to a list of EnvironmentalData
      final List<EnvironmentalData> environmentalDataList =
          List.generate(listLength, (index) {
        return EnvironmentalData(
          time: humidityData[index].time,
          date: humidityData[index]
              .date, // Assuming all lists have matching dates
          humidity: humidityData[index].data,
          soilMoisture: soilMoistureData[index].data,
          light: lightData[index].data,
          co2: co2Data[index].data,
          rain: rainData[index].data,
        );
      });
      emit(FieldAnalysisDailyFullDataSuccess(data: environmentalDataList));
    } catch (e) {
      emit(const FieldAnalysisDailyFullDataFailure(
        errorMessage: 'Failed to fetch daily data.',
      ));
    }
  }

  Future<void> _onWeeklyFullDataRequested(
    FieldAnaylysisWeeklyFullDataRequested event,
    Emitter<FieldAnalysisState> emit,
  ) async {
    emit(FieldAnalysisLoading());
    try {
      // Fetching data for each sensor type as lists
      final List<StatisticData> humidityData =
          await _environmentalDataRepository.getWeeklyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.humidity,
      );

      final List<StatisticData> soilMoistureData =
          await _environmentalDataRepository.getWeeklyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.soilMoisture,
      );

      final List<StatisticData> lightData =
          await _environmentalDataRepository.getWeeklyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.light,
      );

      final List<StatisticData> co2Data =
          await _environmentalDataRepository.getWeeklyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.gasVolume,
      );

      final List<StatisticData> rainData =
          await _environmentalDataRepository.getWeeklyStatistic(
        date: event.date,
        fieldId: event.fieldId,
        type: SensorType.rainVolume,
      );

      // Validate all lists have the same length
      final int listLength = humidityData.length;
      if (soilMoistureData.length != listLength ||
          lightData.length != listLength ||
          co2Data.length != listLength ||
          rainData.length != listLength) {
        throw Exception("Mismatched data lengths between sensor types.");
      }

      // Map the data to a list of EnvironmentalData
      final List<EnvironmentalData> environmentalDataList =
          List.generate(listLength, (index) {
        return EnvironmentalData(
          time: humidityData[index].time,
          date: humidityData[index]
              .date, // Assuming all lists have matching dates
          humidity: humidityData[index].data,
          soilMoisture: soilMoistureData[index].data,
          light: lightData[index].data,
          co2: co2Data[index].data,
          rain: rainData[index].data,
        );
      });
      emit(FieldAnalysisWeeklyFullDataSuccess(data: environmentalDataList));
    } catch (e) {
      emit(const FieldAnalysisWeeklyFullDataFailure(
        errorMessage: 'Failed to fetch weekly data.',
      ));
    }
  }
}
