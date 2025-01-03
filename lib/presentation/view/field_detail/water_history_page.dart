import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_history_item.dart';

class WaterHistoryPage extends StatefulWidget {
  const WaterHistoryPage({super.key});

  @override
  State<WaterHistoryPage> createState() => _WaterHistoryPageState();
}

class _WaterHistoryPageState extends State<WaterHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            "Water History",
            style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHistoryByDay("Today"),
                  _buildHistoryByDay("Yesterday"),
                  _buildHistoryByDay("Last Week"),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryByDay(String day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: AppTextStyle.defaultBold(),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true, // Prevents ListView from expanding infinitely
          physics:
              const NeverScrollableScrollPhysics(), // Makes it non-scrollable
          itemCount: FakeData.fakeWaterHistories.length,
          itemBuilder: (context, index) {
            return WaterHistoryItem(
              waterHistory: FakeData.fakeWaterHistories[index],
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
