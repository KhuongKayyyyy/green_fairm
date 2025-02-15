part of 'water_history_bloc.dart';

sealed class WaterHistoryEvent extends Equatable {
  const WaterHistoryEvent();

  @override
  List<Object> get props => [];
}

final class WaterHistoryRequested extends WaterHistoryEvent {
  final String fieldId;

  const WaterHistoryRequested({
    required this.fieldId,
  });

  @override
  List<Object> get props => [fieldId];
}

final class WaterHistoryClearAllRequested extends WaterHistoryEvent {
  final String fieldId;

  const WaterHistoryClearAllRequested({
    required this.fieldId,
  });

  @override
  List<Object> get props => [fieldId];
}
