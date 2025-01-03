import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/presentation/view/main/home/widget/indicator.dart';

class WaterPieChartWidget extends StatefulWidget {
  const WaterPieChartWidget({super.key});

  @override
  State<StatefulWidget> createState() => WaterPieChartWidgetState();
}

class WaterPieChartWidgetState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Column(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width:
                    double.infinity, // Ensures both rows take up the same width
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Indicator(
                        color: AppColors.primaryColor,
                        text: 'Optimal',
                        isSquare: false,
                        size: touchedIndex == 0 ? 18 : 16,
                        textColor: touchedIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.black,
                      ),
                    ),
                    Expanded(
                      child: Indicator(
                        color: AppColors.secondaryColor,
                        text: 'Serious Attention',
                        isSquare: false,
                        size: touchedIndex == 1 ? 18 : 16,
                        textColor: touchedIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width:
                    double.infinity, // Ensures both rows take up the same width
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Indicator(
                        color: AppColors.accentColor,
                        text: 'Saturated/ Full',
                        isSquare: false,
                        size: touchedIndex == 2 ? 18 : 16,
                        textColor: touchedIndex == 2
                            ? AppColors.primaryColor
                            : AppColors.black,
                      ),
                    ),
                    Expanded(
                      child: Indicator(
                        color: AppColors.lightbg,
                        text: 'N/A',
                        isSquare: false,
                        size: touchedIndex == 3 ? 18 : 16,
                        textColor: touchedIndex == 3
                            ? AppColors.primaryColor
                            : AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = AppColors.primaryColor;
        const color1 = AppColors.secondaryColor;
        const color2 = AppColors.accentColor;
        const color3 = AppColors.lightbg;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 10,
              title: '',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(color: AppColors.contentColorWhite.withAlpha(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 25,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(color: AppColors.contentColorWhite.withAlpha(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 40,
              title: '',
              radius: 60,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(color: AppColors.contentColorWhite.withAlpha(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 25,
              title: '',
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(color: AppColors.contentColorWhite.withAlpha(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
