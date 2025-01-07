import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryDetailAnalysis extends StatefulWidget {
  final String category;
  const CategoryDetailAnalysis({super.key, required this.category});

  @override
  State<CategoryDetailAnalysis> createState() => _CategoryDetailAnalysisState();
}

class _CategoryDetailAnalysisState extends State<CategoryDetailAnalysis> {
  List<EnvironmentalData> chartData = FakeData.fakeWeekChartData;

  // Method to calculate the average humidity
  double calculateAverageHumidity() {
    if (chartData.isEmpty) return 0; // Handle the case where data is empty
    final totalHumidity = chartData.fold<num>(
      0,
      (sum, data) => sum + (data.humidity ?? 0),
    );
    return totalHumidity / chartData.length;
  }

  @override
  Widget build(BuildContext context) {
    final averageHumidity = calculateAverageHumidity(); // Calculate average

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(widget.category, style: AppTextStyle.defaultBold()),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Graph of ${widget.category}",
                style: AppTextStyle.defaultBold()),
            _buildGraph(averageHumidity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Update today, ${TimeOfDay.now().format(context)}",
                style: AppTextStyle.defaultBold(color: AppColors.grey),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Info",
                style: AppTextStyle.defaultBold(color: AppColors.grey),
              ),
            ),
            _buildInfo()
          ],
        ),
      ),
    );
  }

  Container _buildInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.lightbg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.wb_sunny,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(widget.category, style: AppTextStyle.defaultBold()),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 1),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Sensor name:",
                style: AppTextStyle.defaultBold(),
              ),
              const Spacer(),
              Text(
                "DHT-11",
                style: AppTextStyle.defaultBold()
                    .copyWith(color: AppColors.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildGraph(double averageHumidity) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 50),
            series: <ChartSeries>[
              LineSeries<EnvironmentalData, String>(
                dataSource: chartData,
                xValueMapper: (EnvironmentalData data, _) => data.date,
                yValueMapper: (EnvironmentalData data, _) => data.humidity,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: AppTextStyle.smallBold(),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: [
              Text(
                "Week average ${widget.category}: ",
                style: AppTextStyle.defaultBold(),
              ),
              const Spacer(),
              Text(
                "${averageHumidity.toStringAsFixed(2)}%", // Display average
                style: AppTextStyle.defaultBold()
                    .copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
