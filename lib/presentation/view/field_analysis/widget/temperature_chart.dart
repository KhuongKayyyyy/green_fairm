import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureChart extends StatelessWidget {
  final bool showPointValue;
  final List<StatisticData> chartData;
  const TemperatureChart(
      {super.key, required this.chartData, required this.showPointValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 25),
        series: <ChartSeries>[
          LineSeries<StatisticData, String>(
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              color: AppColors.accentColor,
            ),
            color: AppColors.secondaryColor,
            dataSource: chartData,
            xValueMapper: (StatisticData data, _) => data.date,
            yValueMapper: (StatisticData data, _) => data.data,
            dataLabelSettings: DataLabelSettings(
                isVisible: showPointValue, textStyle: AppTextStyle.smallBold()),
          ),
        ],
      ),
    );
  }
}
