import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/sensor_type.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/presentation/bloc/field_analysis/field_analysis_bloc.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/temperature_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class WeeklyStackedChart extends StatefulWidget {
  final String fieldId;
  final ChartPointInteractionCallback? onPointTap;

  const WeeklyStackedChart({
    super.key,
    this.onPointTap,
    required this.fieldId,
  });

  factory WeeklyStackedChart.weekly({
    Key? key,
    ChartPointInteractionCallback? onPointTap,
    required String fieldId,
  }) {
    return WeeklyStackedChart(
      key: key,
      onPointTap: onPointTap,
      fieldId: fieldId,
    );
  }
  @override
  State<WeeklyStackedChart> createState() => _WeeklyStackedChartState();
}

class _WeeklyStackedChartState extends State<WeeklyStackedChart> {
  late PageController _controller;
  bool _showPointValue = false;
  bool _showTempChart = false;
  late List<EnvironmentalData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  final FieldAnalysisBloc tempBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc allDataWeek1Bloc = FieldAnalysisBloc();
  final FieldAnalysisBloc allDataWeek2Bloc = FieldAnalysisBloc();
  final FieldAnalysisBloc allDataWeek3Bloc = FieldAnalysisBloc();

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
    _chartData = FakeData.fakeWeekChartData;
    _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: true);

    tempBloc.add(FieldAnalysisWeeklyDataRequested(
        date: Helper.getTodayDateFormatted(),
        fieldId: widget.fieldId,
        type: SensorType.temperature));
    allDataWeek1Bloc.add(FieldAnaylysisWeeklyFullDataRequested(
        date: Helper.getTodayDateFormatted(), fieldId: widget.fieldId));
    allDataWeek2Bloc.add(FieldAnaylysisWeeklyFullDataRequested(
        date: Helper.getFirstDateOfLastWeek(), fieldId: widget.fieldId));
    allDataWeek3Bloc.add(FieldAnaylysisWeeklyFullDataRequested(
        date: Helper.getFirstDateOfLastTwoWeeks(), fieldId: widget.fieldId));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showTempChart)
          _buildTempChart()
        else
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: _buildPageViewStackedChart()),
        const SizedBox(height: 15),
        _buildControlButtons(),
      ],
    );
  }

  Widget _buildTempChart() {
    return BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
      bloc: tempBloc,
      builder: (context, tempState) {
        if (tempState is FieldAnalysisWeeklyDataSuccess) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TemperatureChart(
              showPointValue: _showPointValue,
              chartData: tempState.data,
            ),
          );
        } else if (tempState is FieldAnalysisWeeklyDataFailure) {
          return Text(tempState.errorMessage);
        }
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TemperatureChart(
              showPointValue: _showPointValue,
              chartData: FakeData.fakeWeeklyTemperature,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageViewStackedChart() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildWeeklyStackedChart("Week 1", allDataWeek1Bloc);
          } else if (index == 1) {
            return _buildWeeklyStackedChart("Week 2", allDataWeek2Bloc);
          } else {
            return _buildWeeklyStackedChart("Week 3", allDataWeek3Bloc);
          }
        },
      ),
    );
  }

  Widget _buildWeeklyStackedChart(
      String title, FieldAnalysisBloc fieldAnalysisBloc) {
    return BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
      bloc: fieldAnalysisBloc,
      builder: (context, allDataState) {
        if (allDataState is FieldAnalysisWeeklyFullDataSuccess) {
          _chartData = allDataState.data;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SfCartesianChart(
              tooltipBehavior: _tooltipBehavior,
              title:
                  ChartTitle(text: title, textStyle: AppTextStyle.smallBold()),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              primaryXAxis: CategoryAxis(
                labelRotation: -45,
                interval: 1,
                majorGridLines: const MajorGridLines(width: 0),
              ),
              series: _buildStackedSeries(_chartData),
            ),
          );
        } else if (allDataState is FieldAnalysisWeeklyFullDataFailure) {
          return Center(
            child: Text(allDataState.errorMessage),
          );
        }
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        );
      },
    );
  }

  List<StackedColumnSeries<EnvironmentalData, String>> _buildStackedSeries(
      List<EnvironmentalData> data) {
    return [
      StackedColumnSeries<EnvironmentalData, String>(
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.humidity,
        name: 'Humidity',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
        onPointTap: (details) {
          final index = details.pointIndex; // Get the tapped point index
          if (widget.onPointTap != null && index != null) {
            widget.onPointTap!(details);
          }
        },
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        dataSource: _chartData,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.light,
        name: 'Light',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
        onPointTap: (details) {
          final index = details.pointIndex; // Get the tapped point index
          if (widget.onPointTap != null && index != null) {
            widget.onPointTap!(details);
          }
        },
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        dataSource: _chartData,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.soilMoisture,
        name: 'Soil Moisture',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
        onPointTap: (details) {
          final index = details.pointIndex; // Get the tapped point index
          if (widget.onPointTap != null && index != null) {
            widget.onPointTap!(details);
          }
        },
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        dataSource: _chartData,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.co2,
        name: 'CO2',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
        onPointTap: (details) {
          final index = details.pointIndex; // Get the tapped point index
          if (widget.onPointTap != null && index != null) {
            widget.onPointTap!(details);
          }
        },
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        dataSource: _chartData,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.rain,
        name: 'Rain',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
        onPointTap: (details) {
          final index = details.pointIndex; // Get the tapped point index
          if (widget.onPointTap != null && index != null) {
            widget.onPointTap!(details);
          }
        },
      ),
    ];
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: PrimaryButton(
            text: _showPointValue ? "Hide Values" : "Show Values",
            onPressed: () {
              setState(() {
                _showPointValue = !_showPointValue;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: _showTempChart ? "Env Chart" : "Temp Chart",
            onPressed: () {
              setState(() {
                _showTempChart = !_showTempChart;
              });
            },
          ),
        ),
      ],
    );
  }
}
