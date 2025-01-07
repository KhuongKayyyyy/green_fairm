import 'package:flutter/material.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/temperature_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class WeeklyStackedChart extends StatefulWidget {
  final ChartPointInteractionCallback? onPointTap;

  const WeeklyStackedChart({
    super.key,
    this.onPointTap,
  });

  factory WeeklyStackedChart.weekly(
      {Key? key, ChartPointInteractionCallback? onPointTap}) {
    return WeeklyStackedChart(key: key, onPointTap: onPointTap);
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

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
    _chartData = FakeData.fakeWeekChartData;
    _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: true);
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TemperatureChart(
              chartData: FakeData.fakeWeeklyTemperature,
            ),
          )
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

  Widget _buildPageViewStackedChart() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildWeeklyStackedChart("Week ${index + 1}");
        },
      ),
    );
  }

  Widget _buildWeeklyStackedChart(String title) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        title: ChartTitle(text: title, textStyle: AppTextStyle.smallBold()),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        primaryXAxis: CategoryAxis(
          labelRotation: -45,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 0),
        ),
        series: _buildStackedSeries(),
      ),
    );
  }

  List<StackedColumnSeries<EnvironmentalData, String>> _buildStackedSeries() {
    return [
      StackedColumnSeries<EnvironmentalData, String>(
        dataSource: _chartData,
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
