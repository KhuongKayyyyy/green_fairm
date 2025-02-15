import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:green_fairm/data/model/water_history.dart';
import 'package:green_fairm/data/res/water_history_repository.dart';

part 'water_history_event.dart';
part 'water_history_state.dart';

class WaterHistoryBloc extends Bloc<WaterHistoryEvent, WaterHistoryState> {
  final WaterHistoryRepository _waterHistoryRepository =
      WaterHistoryRepository();
  WaterHistoryBloc() : super(WaterHistoryInitial()) {
    on<WaterHistoryEvent>((event, emit) {});

    on<WaterHistoryRequested>(_onRequested);
    on<WaterHistoryClearAllRequested>(_onClearAllRequested);
  }

  Future<void> _onRequested(
    WaterHistoryRequested event,
    Emitter<WaterHistoryState> emit,
  ) async {
    emit(WaterHistoryLoading());
    try {
      final waterHistories = await _waterHistoryRepository
          .fetchWaterHistoryByFieldId(event.fieldId);
      emit(WaterHistoryLoaded(waterHistories: waterHistories));
    } catch (e) {
      emit(const WaterHistoryError(message: 'An unknown error occurred'));
    }
  }

  Future<void> _onClearAllRequested(
    WaterHistoryClearAllRequested event,
    Emitter<WaterHistoryState> emit,
  ) async {
    emit(WaterHistoryLoading());
    try {
      await _waterHistoryRepository
          .clearAllWaterHistoryByFieldId(event.fieldId);
      emit(WaterHistoryClearAllSuccess());
    } catch (e) {
      emit(const WaterHistoryError(message: 'An unknown error occurred'));
    }
  }
}
