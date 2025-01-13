import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/daily_stacked_chart.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/weekly_stacked_chart.dart';

class FieldAnalysisPage extends StatefulWidget {
  final Field field;

  const FieldAnalysisPage({super.key, required this.field});

  @override
  State<FieldAnalysisPage> createState() => _FieldAnalysisPageState();
}

class _FieldAnalysisPageState extends State<FieldAnalysisPage> {
  int _slidingIndex = 0;
  String _initialDate = Helper.getTodayDateFormatted();

  void _handlePointTap(String date) {
    print(date);
    setState(() {
      _initialDate = date;
      _slidingIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey.withOpacity(0.1),
        title: Text(
          widget.field.name!,
          style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
        ),
      ),
      body: Container(
        color: AppColors.grey.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<int>(
                thumbColor: AppColors.primaryColor.withOpacity(0.5),
                children: {
                  0: Text(
                    "Weekly",
                    style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 0
                          ? AppColors.secondaryColor
                          : Colors.grey,
                    ),
                  ),
                  1: Text(
                    "Daily",
                    style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 1
                          ? AppColors.secondaryColor
                          : Colors.grey,
                    ),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    _slidingIndex = value!;
                  });
                },
                groupValue: _slidingIndex,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _slidingIndex == 0
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          WeeklyStackedChart.weekly(
                            fieldId: widget.field.id!,
                            onPointTap: _handlePointTap,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          DailyStackedChart(
                            initialDate: _initialDate,
                            fieldId: widget.field.id!,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
