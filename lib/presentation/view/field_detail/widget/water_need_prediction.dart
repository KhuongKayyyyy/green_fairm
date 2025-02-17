import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/machine_learning/ml_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WaterNeedPrediction extends StatefulWidget {
  final Field field;
  const WaterNeedPrediction({super.key, required this.field});

  @override
  State<WaterNeedPrediction> createState() => _WaterNeedPredictionState();
}

class _WaterNeedPredictionState extends State<WaterNeedPrediction> {
  final MlBloc _mlBloc = MlBloc();
  DateTime? _endTime; // Make it nullable

  @override
  void initState() {
    super.initState();
    _mlBloc.add(MlWaterNeedRequested(
      date: Helper.getTodayDateFormatted(),
      fieldId: widget.field.id!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MlBloc, MlState>(
      bloc: _mlBloc,
      builder: (context, state) {
        if (state is MlWaterNeedFailure) {
          return const Center(
            child: Text('Failed to get water need prediction'),
          );
        }
        if (state is MlWaterNeedSuccess) {
          // Set end time only if it's null (first time)
          _endTime ??=
              DateTime.now().add(_convertMinutesToDuration(state.waterNeed));
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Water need prediction:",
                style: AppTextStyle.defaultBold(),
              ),
              const SizedBox(height: 10),
              if (_endTime != null)
                TimerCountdown(
                  timeTextStyle: AppTextStyle.defaultBold(),
                  format: CountDownTimerFormat.hoursMinutesSeconds,
                  endTime: _endTime!,
                  onEnd: () {
                    print("Timer finished");
                  },
                )
              else
                Skeletonizer(
                    child: TimerCountdown(
                  timeTextStyle: AppTextStyle.defaultBold(),
                  format: CountDownTimerFormat.hoursMinutesSeconds,
                  endTime: DateTime.now(),
                  onEnd: () {
                    print("Timer finished");
                  },
                ))
            ],
          ),
        );
      },
    );
  }

  Duration _convertMinutesToDuration(double minutes) {
    int totalSeconds = (minutes * 60).toInt();
    int days = totalSeconds ~/ (24 * 3600);
    totalSeconds %= (24 * 3600);
    int hours = totalSeconds ~/ 3600;
    totalSeconds %= 3600;
    int mins = totalSeconds ~/ 60;
    int secs = totalSeconds % 60;
    return Duration(days: days, hours: hours, minutes: mins, seconds: secs);
  }
}
