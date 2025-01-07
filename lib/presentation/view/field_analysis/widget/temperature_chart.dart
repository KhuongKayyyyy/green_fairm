import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureChart extends StatelessWidget {
  final List<TemperatureData> chartData;
  const TemperatureChart({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 25),
        series: <ChartSeries>[
          LineSeries<TemperatureData, String>(
            color: AppColors.accentColor,
            dataSource: chartData,
            xValueMapper: (TemperatureData data, _) => data.date,
            yValueMapper: (TemperatureData data, _) => data.temperature,
            dataLabelSettings: DataLabelSettings(
                isVisible: true, textStyle: AppTextStyle.smallBold()),
          ),
        ],
      ),
    );
  }
}
