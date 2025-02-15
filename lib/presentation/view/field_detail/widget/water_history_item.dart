import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/water_history.dart';
import 'package:intl/intl.dart';

class WaterHistoryItem extends StatelessWidget {
  final WaterHistory waterHistory;
  const WaterHistoryItem({super.key, required this.waterHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: const Icon(
                  Icons.opacity,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              formatDate(waterHistory.endDate!).split(', ')[0],
                          style: AppTextStyle.defaultBold(color: Colors.blue),
                        ),
                        TextSpan(
                          text:
                              ', ${formatDate(waterHistory.endDate!).split(', ')[1]}',
                          style: AppTextStyle.defaultBold(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    calculateTimeDifference(
                        waterHistory.startDate!, waterHistory.endDate!),
                    style: AppTextStyle.defaultBold(color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "Done",
                style: AppTextStyle.defaultBold(color: AppColors.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 5,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  String formatDate(String isoDateString) {
    DateTime dateTime =
        DateTime.parse(isoDateString).toLocal(); // Convert to local timezone
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (dateTime.isAfter(today)) {
      return 'Today, ${DateFormat('dd MMM yyyy').format(dateTime)}';
    } else if (dateTime.isAfter(yesterday)) {
      return 'Yesterday, ${DateFormat('dd MMM yyyy').format(dateTime)}';
    } else {
      return DateFormat('EEEE, dd MMM yyyy').format(dateTime);
    }
  }

  String calculateTimeDifference(String start, String end) {
    DateTime startTime = DateTime.parse(start).toLocal();
    DateTime endTime = DateTime.parse(end).toLocal();

    Duration difference = endTime.difference(startTime);

    if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes.remainder(60)}m ${difference.inSeconds.remainder(60)}s';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ${difference.inSeconds.remainder(60)}s';
    } else {
      return '${difference.inSeconds}s';
    }
  }
}
