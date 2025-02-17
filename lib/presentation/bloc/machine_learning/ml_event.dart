part of 'ml_bloc.dart';

sealed class MlEvent extends Equatable {
  const MlEvent();

  @override
  List<Object> get props => [];
}

final class MlHealthPredictionRequested extends MlEvent {
  final String date;
  final String fieldId;

  const MlHealthPredictionRequested(
      {required this.date, required this.fieldId});

  @override
  List<Object> get props => [date, fieldId];
}

final class MlWaterNeedRequested extends MlEvent {
  final String date;
  final String fieldId;

  const MlWaterNeedRequested({required this.date, required this.fieldId});

  @override
  List<Object> get props => [date, fieldId];
}
