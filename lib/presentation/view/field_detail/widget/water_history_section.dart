import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/view/field_detail/water_history_page.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_history_item.dart';

class WaterHistorySection extends StatefulWidget {
  const WaterHistorySection({super.key});

  @override
  State<WaterHistorySection> createState() => _WaterHistorySectionState();
}

class _WaterHistorySectionState extends State<WaterHistorySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Water History",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _onSeeAll();
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 5,
              itemBuilder: (context, index) {
                return WaterHistoryItem(
                  waterHistory: FakeData.fakeWaterHistories[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _onSeeAll() {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) => const WaterHistoryPage(),
    );
  }
}
