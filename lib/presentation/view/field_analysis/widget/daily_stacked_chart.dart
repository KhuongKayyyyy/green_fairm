import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/temperature_chart.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyStackedChart extends StatefulWidget {
  final int? initalIndex;
  const DailyStackedChart({super.key, this.initalIndex});

  @override
  State<DailyStackedChart> createState() => _DailyStackedChartState();
}

class _DailyStackedChartState extends State<DailyStackedChart> {
  late PageController _pageController;
  late final List<EnvironmentalData> _dailyChartData;
  late final List<EnvironmentalData> _weeklyChartData;
  String _selectedDate = '';

  bool _showPointValue = false;
  bool _showTempChart = false;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _selectedDate = "Today, 6 Janurary";
    _dailyChartData = FakeData.fakeDailyChartData;
    _weeklyChartData = FakeData.fakeWeekChartData;
    _pageController = PageController(viewportFraction: 0.9);
    if (widget.initalIndex != null) {
      _pageController = PageController(initialPage: widget.initalIndex!);
    }
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showTempChart)
          TemperatureChart(
            chartData: FakeData.fakeDailyTemperature,
          )
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
      ],
    );
  }

  Widget _buildWeekStackedChart() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: SfCartesianChart(
        title: ChartTitle(
            text: _selectedDate, textStyle: AppTextStyle.smallBold()),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: _buildStackedSeries(_weeklyChartData, true),
        tooltipBehavior: _tooltipBehavior,
      ),
    );
  }

  Widget _buildDailyStackedChart() {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: 7,
          itemBuilder: (context, index) {
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              series: _buildStackedSeries(_dailyChartData, false),
              tooltipBehavior: _tooltipBehavior,
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
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.humidity,
        name: 'Humidity',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.light,
        name: 'Light',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.soilMoisture,
        name: 'Soil Moisture',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.date,
        yValueMapper: (EnvironmentalData data, _) => data.co2,
        name: 'CO2',
        dataLabelSettings: DataLabelSettings(
          isVisible: _showPointValue,
          textStyle: AppTextStyle.smallBold(),
        ),
      ),
      StackedColumnSeries<EnvironmentalData, String>(
        onPointTap: isJumaple ? _onPointTap : null,
        dataSource: data,
        xValueMapper: (EnvironmentalData data, _) => data.date,
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
    _pageController.animateToPage(
      args.pointIndex!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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
