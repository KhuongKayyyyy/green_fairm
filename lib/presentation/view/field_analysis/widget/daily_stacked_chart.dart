import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/constant/sensor_type.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/presentation/bloc/field_analysis/field_analysis_bloc.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/data_list.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/temperature_chart.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyStackedChart extends StatefulWidget {
  final String fieldId;
  final String initialDate;
  const DailyStackedChart(
      {super.key, required this.fieldId, required this.initialDate});

  @override
  State<DailyStackedChart> createState() => _DailyStackedChartState();
}

class _DailyStackedChartState extends State<DailyStackedChart> {
  late PageController _pageController;

  String _selectedDate = "";

  bool _showPointValue = false;
  bool _showTempChart = false;
  late TooltipBehavior _tooltipBehavior;

  // bloc
  final FieldAnalysisBloc tempBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc allDataWeekBloc = FieldAnalysisBloc();
  final FieldAnalysisBloc allDataWeek2Bloc = FieldAnalysisBloc();
  final FieldAnalysisBloc allDataWeek3Bloc = FieldAnalysisBloc();

  late final List<FieldAnalysisBloc> dailyBlocs;
  late final List<String> weekDates;

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.9,
      initialPage: Helper.getIndexOfDateInWeek(widget.initialDate) + 1,
    )..addListener(() {
        final int currentPage = _pageController.page!.round();
        final int reversedIndex = weekDates.length - 1 - currentPage;
        if (reversedIndex >= 0 && reversedIndex < weekDates.length) {
          setState(() {
            _selectedDate =
                Helper.getFormattedDateWithDay(weekDates[reversedIndex]);
          });
          print('Selected Date on Swipe: $_selectedDate');
        }
      });
    _selectedDate = Helper.getFormattedDateWithDay(widget.initialDate);

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: true,
    );

    _pageController.addListener(() {});

    super.initState();
    //bloc
    tempBloc.add(FieldAnalysisDailyDataRequested(
        date: widget.initialDate,
        fieldId: widget.fieldId,
        type: SensorType.temperature));
    allDataWeekBloc.add(FieldAnaylysisWeeklyFullDataRequested(
      date: widget.initialDate,
      fieldId: widget.fieldId,
    ));
    // allDataWeek2Bloc.add(FieldAnaylysisWeeklyFullDataRequested(
    //     date: Helper.getFirstDateOfLastWeek(), fieldId: widget.fieldId));
    // allDataWeek3Bloc.add(FieldAnaylysisWeeklyFullDataRequested(
    //     date: Helper.getFirstDateOfLastTwoWeeks(), fieldId: widget.fieldId));
    if (Helper.isDateInCurrentWeek(widget.initialDate)) {
      dailyBlocs = List.generate(
        Helper.getPassedDaysOfCurrentWeek().length,
        (index) {
          final bloc = FieldAnalysisBloc();
          final date = Helper.getPassedDaysOfCurrentWeek().elementAt(
              Helper.getPassedDaysOfCurrentWeek().length - 1 - index);
          bloc.add(FieldAnaylysisDailyFullDataRequested(
            date: date,
            fieldId: widget.fieldId,
          ));
          return bloc;
        },
      );
    } else {
      dailyBlocs = List.generate(
        Helper.getDatesOfWeek(widget.initialDate).length,
        (index) {
          final bloc = FieldAnalysisBloc();
          final date = Helper.getDatesOfWeek(widget.initialDate).elementAt(
              Helper.getDatesOfWeek(widget.initialDate).length - 1 - index);
          bloc.add(FieldAnaylysisDailyFullDataRequested(
            date: date,
            fieldId: widget.fieldId,
          ));
          return bloc;
        },
      );
    }

    weekDates = Helper.getPassedDaysOfCurrentWeek();
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
            child: Column(
              children: [
                _buildWeekStackedChart(),
                _buildDailyStackedChart(),
              ],
            ),
          ),
        const SizedBox(height: 16),
        _buildControlButtons(),
        DataList(
          key: ValueKey(widget.initialDate),
          fieldId: widget.fieldId,
          isWeekly: true,
          date: widget.initialDate,
        ),
      ],
    );
  }

  Widget _buildTempChart() {
    return BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
      bloc: tempBloc,
      builder: (context, tempState) {
        if (tempState is FieldAnalysisDailyDataSuccess) {
          return TemperatureChart(
            showPointValue: _showPointValue,
            chartData: tempState.data,
          );
        } else if (tempState is FieldAnalysisDailyDataFailure) {
          return Center(
            child: Text(tempState.errorMessage),
          );
        }
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: true,
          child: TemperatureChart(
            showPointValue: _showPointValue,
            chartData: FakeData.fakeDailyTemperature,
          ),
        );
      },
    );
  }

  Widget _buildWeekStackedChart() {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
          bloc: allDataWeekBloc,
          builder: (context, allWeekDataState) {
            if (allWeekDataState is FieldAnalysisWeeklyFullDataSuccess) {
              return SfCartesianChart(
                title: ChartTitle(
                    text: _selectedDate, textStyle: AppTextStyle.smallBold()),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: _buildStackedSeries(allWeekDataState.data, true),
                tooltipBehavior: _tooltipBehavior,
              );
            } else if (allWeekDataState is FieldAnalysisWeeklyFullDataFailure) {
              return Center(
                child: Text(allWeekDataState.errorMessage),
              );
            }
            return Container(
              width: 50,
              height: MediaQuery.of(context).size.height * 0.25,
              color: Colors.white,
              child: const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 4.0, // Optional: Adjust thickness
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget _buildDailyStackedChart() {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: dailyBlocs.length,
          itemBuilder: (context, index) {
            return BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
              bloc: dailyBlocs[index],
              builder: (context, allDayDataState) {
                if (allDayDataState is FieldAnalysisDailyFullDataSuccess) {
                  return SfCartesianChart(
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    series: _buildStackedSeries(allDayDataState.data, true),
                    tooltipBehavior: _tooltipBehavior,
                  );
                } else if (allDayDataState
                    is FieldAnalysisDailyFullDataFailure) {
                  return Center(
                    child: Text(allDayDataState.errorMessage),
                  );
                }
                return Container(
                  width: 50,
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.white,
                  child: const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 4.0, // Optional: Adjust thickness
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }

  List<StackedColumnSeries<EnvironmentalData, String>> _buildStackedSeries(
      List<EnvironmentalData> data, bool isJumaple) {
    return [
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.time,
        yValueMapper: (EnvironmentalData data, _) => data.humidity,
        name: 'Humidity',
        color: AppColors.secondaryColor,
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.time,
        yValueMapper: (EnvironmentalData data, _) => data.light,
        name: 'Light',
        color: AppColors.primaryColor,
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.time,
        yValueMapper: (EnvironmentalData data, _) => data.soilMoisture,
        name: 'Soil Moisture',
        color: AppColors.accentColor,
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.time,
        yValueMapper: (EnvironmentalData data, _) => data.co2,
        name: 'CO2',
        color: AppColors.lightbg,
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.time,
        yValueMapper: (EnvironmentalData data, _) => data.rain,
        name: 'Rain',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
    ];
  }

  void _onPointTap(ChartPointDetails args) {
    final reversedIndex = dailyBlocs.length - 1 - args.pointIndex!;
    _pageController.animateToPage(
      reversedIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _selectedDate = Helper.getFormattedDateWithDay(args
          .dataPoints![dailyBlocs.length - 1 - args.pointIndex!].x
          .toString());
    });
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
