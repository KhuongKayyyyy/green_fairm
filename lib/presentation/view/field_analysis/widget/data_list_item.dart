import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class DataListItem extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String title;
  final num data;

  const DataListItem({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                // Center widget added here
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightbg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (data / 100).clamp(0.0, 1.0).toDouble(),
                            backgroundColor: AppColors.lightbg,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${data.toStringAsFixed(0)}%',
                          style: AppTextStyle.smallBold(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                color: AppColors.secondaryColor,
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
