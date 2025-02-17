part of 'ml_bloc.dart';

sealed class MlState extends Equatable {
  const MlState();

  @override
  List<Object> get props => [];
}

final class MlInitial extends MlState {}

final class MlLoading extends MlState {}

final class MlHealthPredictionSuccess extends MlState {
  final double healthPredictions;

  const MlHealthPredictionSuccess({required this.healthPredictions});

  @override
  List<Object> get props => [healthPredictions];
}

final class MlHealthPredictionFailure extends MlState {
  final String errorMessage;

  const MlHealthPredictionFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class MlWaterNeedSuccess extends MlState {
  final double waterNeed;

  const MlWaterNeedSuccess({required this.waterNeed});

  @override
  List<Object> get props => [waterNeed];
}

final class MlWaterNeedFailure extends MlState {
  final String errorMessage;

  const MlWaterNeedFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
