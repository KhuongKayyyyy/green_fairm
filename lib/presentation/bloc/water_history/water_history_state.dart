part of 'water_history_bloc.dart';

sealed class WaterHistoryState extends Equatable {
  const WaterHistoryState();

  @override
  List<Object> get props => [];
}

final class WaterHistoryInitial extends WaterHistoryState {}

final class WaterHistoryLoading extends WaterHistoryState {}

final class WaterHistoryLoaded extends WaterHistoryState {
  final List<WaterHistory> waterHistories;

  const WaterHistoryLoaded({
    required this.waterHistories,
  });

  WaterHistoryLoaded copyWith({
    List<WaterHistory>? waterHistories,
  }) {
    return WaterHistoryLoaded(
      waterHistories: waterHistories ?? this.waterHistories,
    );
  }

  @override
  List<Object> get props => [waterHistories];
}

final class WaterHistoryError extends WaterHistoryState {
  final String message;

  const WaterHistoryError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class WaterHistoryClearAllSuccess extends WaterHistoryState {}
