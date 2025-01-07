import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class WaterUsage extends StatefulWidget {
  final String? date;
  const WaterUsage({super.key, this.date});

  @override
  State<WaterUsage> createState() => _WaterUsageState();
}

class _WaterUsageState extends State<WaterUsage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.date ?? "Water Usage",
                style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
              ),
              const Spacer(),
              if (widget.date == null)
                DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                    isDense: true,
                    constraints:
                        BoxConstraints.tight(const Size.fromHeight(80)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "Today", label: "Today"),
                    DropdownMenuEntry(value: "This Week", label: "This Week"),
                    DropdownMenuEntry(value: "This Month", label: "This Month"),
                  ],
                  initialSelection: "Today",
                  onSelected: (String? newValue) {
                    setState(() {});
                  },
                ),
            ],
          ),
          if (widget.date != null) const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildTimeWatered(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildCountWatered(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildCountWatered() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.accentColor.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            CupertinoIcons.clock_fill,
            color: AppColors.accentColor.withOpacity(0.5),
          ),
          const SizedBox(height: 5),
          Text(
            "20",
            style: AppTextStyle.defaultBold(),
          ),
          const SizedBox(height: 5),
          Text(
            "Time water",
            style:
                AppTextStyle.smallBold(color: AppColors.grey.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Container _buildTimeWatered() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.water_drop_sharp,
            color: AppColors.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 5),
          Text(
            "50 minutes",
            style: AppTextStyle.defaultBold(),
          ),
          const SizedBox(height: 5),
          Text(
            "Total watering time",
            style:
                AppTextStyle.smallBold(color: AppColors.grey.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
