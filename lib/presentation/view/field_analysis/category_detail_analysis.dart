import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/presentation/bloc/field_analysis/field_analysis_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryDetailAnalysis extends StatefulWidget {
  final String category;
  final String fieldId;
  final String date;
  final bool isWeekly;
  const CategoryDetailAnalysis(
      {super.key,
      required this.category,
      required this.date,
      required this.fieldId,
      required this.isWeekly});

  @override
  State<CategoryDetailAnalysis> createState() => _CategoryDetailAnalysisState();
}

class _CategoryDetailAnalysisState extends State<CategoryDetailAnalysis> {
  List<StatisticData> chartData = FakeData.fakeDailyTemperature;
  final FieldAnalysisBloc _analysisBloc = FieldAnalysisBloc();

  late final String dataType;

  @override
  void initState() {
    super.initState();

    switch (widget.category) {
      case 'Humidity':
        dataType = 'humidity';
        break;
      case 'Light':
        dataType = 'light';
        break;
      case 'Soil Moisture':
        dataType = 'soilMoisture';
        break;
      case 'CO2':
        dataType = 'gasVolume';
        break;
      case 'Rain':
        dataType = 'rainVolume';
        break;
      default:
        dataType = 'unknown';
    }

    _analysisBloc.add(widget.isWeekly
        ? FieldAnalysisWeeklyDataRequested(
            date: widget.date, fieldId: widget.fieldId, type: dataType)
        : FieldAnalysisDailyDataRequested(
            date: widget.date, fieldId: widget.fieldId, type: dataType));
  }

  @override
  Widget build(BuildContext context) {
    var averageValue = 0;

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
            _buildGraphSection(averageValue.toDouble()),
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
                "${widget.category} Sensor",
                style: AppTextStyle.defaultBold()
                    .copyWith(color: AppColors.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGraphSection(double averageHumidity) {
    return BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
      bloc: _analysisBloc,
      builder: (context, state) {
        if (state is FieldAnalysisDailyDataSuccess) {
          averageHumidity = Helper.calculateAverage(
              state.data.map((data) => data.data).toList());
          return _buildGraph(state.data, averageHumidity);
        } else if (state is FieldAnalysisWeeklyDataSuccess) {
          averageHumidity = Helper.calculateAverage(
              state.data.map((data) => data.data).toList());
          return _buildGraph(state.data, averageHumidity);
        }
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: true,
          child: _buildGraph(FakeData.fakeDailyTemperature, averageHumidity),
        );
      },
    );
  }

  Widget _buildGraph(List<StatisticData> graphData, double averageValue) {
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
            primaryYAxis: NumericAxis(
                minimum:
                    Helper.getMinimumData(graphData).round().toDouble() - 5,
                maximum:
                    Helper.getMaximumData(graphData).round().toDouble() + 5),
            series: <ChartSeries>[
              LineSeries<StatisticData, String>(
                color: AppColors.secondaryColor,
                dataSource: graphData,
                xValueMapper: (StatisticData data, _) => data.time,
                yValueMapper: (StatisticData data, _) =>
                    double.parse(data.data.toStringAsFixed(2)),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: AppTextStyle.smallBold(),
                ),
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                  color: AppColors.accentColor,
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
                widget.isWeekly
                    ? "Week average ${widget.category}: "
                    : "Day average ${widget.category}: ",
                style: AppTextStyle.defaultBold(),
              ),
              const Spacer(),
              Text(
                "${averageValue.toStringAsFixed(2)} %", // Display average
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
