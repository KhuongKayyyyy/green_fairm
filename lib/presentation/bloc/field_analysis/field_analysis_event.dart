part of 'field_analysis_bloc.dart';

sealed class FieldAnalysisEvent extends Equatable {
  const FieldAnalysisEvent();

  @override
  List<Object> get props => [];
}

class FieldAnalysisDailyAverageDataRequested extends FieldAnalysisEvent {
  final String date;
  final String fieldId;

  const FieldAnalysisDailyAverageDataRequested(
      {required this.date, required this.fieldId});

  @override
  List<Object> get props => [date];
}

class FieldAnalysisDailyDataRequested extends FieldAnalysisEvent {
  final String date;
  final String fieldId;
  final String type;

  const FieldAnalysisDailyDataRequested(
      {required this.date, required this.fieldId, required this.type});

  @override
  List<Object> get props => [date];
}

class FieldAnalysisWeeklyDataRequested extends FieldAnalysisEvent {
  final String date;
  final String fieldId;
  final String type;

  const FieldAnalysisWeeklyDataRequested(
      {required this.date, required this.fieldId, required this.type});

  @override
  List<Object> get props => [date];
}

class FieldAnaylysisDailyFullDataRequested extends FieldAnalysisEvent {
  final String date;
  final String fieldId;

  const FieldAnaylysisDailyFullDataRequested(
      {required this.date, required this.fieldId});

  @override
  List<Object> get props => [date];
}

class FieldAnaylysisWeeklyFullDataRequested extends FieldAnalysisEvent {
  final String date;
  final String fieldId;

  const FieldAnaylysisWeeklyFullDataRequested(
      {required this.date, required this.fieldId});

  @override
  List<Object> get props => [date];
}
