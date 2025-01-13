import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/constant/sensor_type.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/presentation/bloc/field_analysis/field_analysis_bloc.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/data_list_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DataList extends StatefulWidget {
  final String fieldId;
  final bool isWeekly;
  final String date;
  const DataList(
      {super.key,
      required this.fieldId,
      required this.isWeekly,
      required this.date});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  final FieldAnalysisBloc _tempAnalysisBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc _humAnalysisBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc _soilAnalysisBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc _co2AnalysisBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc _lightAnalysisBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc _rainAnalysisBloc = FieldAnalysisBloc();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(covariant DataList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isWeekly != widget.isWeekly) {
      _loadData();
    }
  }

  void _loadData() {
    if (widget.isWeekly) {
      _tempAnalysisBloc.add(FieldAnalysisWeeklyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.temperature));
      _humAnalysisBloc.add(FieldAnalysisWeeklyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.humidity));
      _soilAnalysisBloc.add(FieldAnalysisWeeklyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.soilMoisture));
      _co2AnalysisBloc.add(FieldAnalysisWeeklyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.gasVolume));
      _lightAnalysisBloc.add(FieldAnalysisWeeklyDataRequested(
          date: widget.date, fieldId: widget.fieldId, type: SensorType.light));
      _rainAnalysisBloc.add(FieldAnalysisWeeklyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.rainVolume));
    } else {
      _tempAnalysisBloc.add(FieldAnalysisDailyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.temperature));
      _humAnalysisBloc.add(FieldAnalysisDailyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.humidity));
      _soilAnalysisBloc.add(FieldAnalysisDailyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.soilMoisture));
      _co2AnalysisBloc.add(FieldAnalysisDailyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.gasVolume));
      _lightAnalysisBloc.add(FieldAnalysisDailyDataRequested(
          date: widget.date, fieldId: widget.fieldId, type: SensorType.light));
      _rainAnalysisBloc.add(FieldAnalysisDailyDataRequested(
          date: widget.date,
          fieldId: widget.fieldId,
          type: SensorType.rainVolume));
    }
  }

  final List<String> dataTitle = [
    'Humidity',
    'Light',
    'Soil Moisture',
    'CO2',
    'Rain',
  ];

  final List<IconData> dataIcon = [
    Icons.water_drop, // Humidity
    Icons.wb_sunny, // Light
    Icons.grass, // Soil Moisture
    Icons.cloud, // CO2
    Icons.umbrella, // Rain
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          "Detail information",
          style: AppTextStyle.defaultBold(),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildListItem(_humAnalysisBloc, dataIcon[0], dataTitle[0]),
                _buildListItem(_lightAnalysisBloc, dataIcon[1], dataTitle[1]),
                _buildListItem(_soilAnalysisBloc, dataIcon[2], dataTitle[2]),
                _buildListItem(_co2AnalysisBloc, dataIcon[3], dataTitle[3]),
                _buildListItem(_rainAnalysisBloc, dataIcon[4], dataTitle[4]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(
      FieldAnalysisBloc typeBloc, IconData icon, String title) {
    return BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
        bloc: typeBloc,
        builder: (context, state) {
          if (state is FieldAnalysisWeeklyDataSuccess) {
            var valueAvg = Helper.calculateAverage(
                state.data.map((data) => data.data).toList());
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DataListItem(
                icon: icon,
                title: title,
                data: valueAvg,
                onTap: () =>
                    context.pushNamed(Routes.categoryDetailAnalysis, extra: {
                  'category': title,
                  'date': widget.date,
                  'fieldId': widget.fieldId,
                  'isWeekly': true
                }),
              ),
            );
          }
          if (state is FieldAnalysisDailyDataSuccess) {
            var humidityAvg = Helper.calculateAverage(
                state.data.map((data) => data.data).toList());
            if (humidityAvg > 100) {
              humidityAvg =
                  Helper.scaleToPercentageNum(humidityAvg.toInt(), 0, 4095);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DataListItem(
                icon: icon,
                title: title,
                data: humidityAvg,
                onTap: () =>
                    context.pushNamed(Routes.categoryDetailAnalysis, extra: {
                  'category': title,
                  'fieldId': widget.fieldId,
                  'date': widget.date,
                  'isWeekly': widget.isWeekly
                }),
              ),
            );
          }
          return Skeletonizer(
            enableSwitchAnimation: true,
            enabled: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DataListItem(
                icon: dataIcon[0],
                title: dataTitle[0],
                data: 50,
              ),
            ),
          );
        });
  }
}
