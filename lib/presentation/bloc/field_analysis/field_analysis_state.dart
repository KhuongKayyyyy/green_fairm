part of 'field_analysis_bloc.dart';

sealed class FieldAnalysisState extends Equatable {
  const FieldAnalysisState();

  @override
  List<Object?> get props => [];
}

final class FieldAnalysisInitial extends FieldAnalysisState {}

final class FieldAnalysisLoading extends FieldAnalysisState {}

final class FieldAnalysisDailyAverageDataSuccess extends FieldAnalysisState {
  final num temperatureAverage;
  final num humidityAverage;
  final num soilMoistureAverage;

  const FieldAnalysisDailyAverageDataSuccess({
    required this.temperatureAverage,
    required this.humidityAverage,
    required this.soilMoistureAverage,
  });

  @override
  List<Object?> get props =>
      [temperatureAverage, humidityAverage, soilMoistureAverage];
}

class FieldAnalysisDailyAverageDataFailure extends FieldAnalysisState {
  final String errorMessage;

  const FieldAnalysisDailyAverageDataFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FieldAnalysisDailyDataSuccess extends FieldAnalysisState {
  final List<StatisticData> data;

  const FieldAnalysisDailyDataSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class FieldAnalysisDailyDataFailure extends FieldAnalysisState {
  final String errorMessage;

  const FieldAnalysisDailyDataFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FieldAnalysisWeeklyDataSuccess extends FieldAnalysisState {
  final List<StatisticData> data;

  const FieldAnalysisWeeklyDataSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class FieldAnalysisWeeklyDataFailure extends FieldAnalysisState {
  final String errorMessage;

  const FieldAnalysisWeeklyDataFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FieldAnalysisDailyFullDataSuccess extends FieldAnalysisState {
  final List<EnvironmentalData> data;

  const FieldAnalysisDailyFullDataSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class FieldAnalysisDailyFullDataFailure extends FieldAnalysisState {
  final String errorMessage;

  const FieldAnalysisDailyFullDataFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FieldAnalysisWeeklyFullDataSuccess extends FieldAnalysisState {
  final List<EnvironmentalData> data;

  const FieldAnalysisWeeklyFullDataSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class FieldAnalysisWeeklyFullDataFailure extends FieldAnalysisState {
  final String errorMessage;

  const FieldAnalysisWeeklyFullDataFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
