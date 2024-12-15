import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/field.dart';

class FieldSmallItem extends StatelessWidget {
  final Field field;
  const FieldSmallItem({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    width: double.infinity,
                    "https://www.artefact.com//wp-content/uploads/2021/06/Satellite-Photo-by-Red-Zeppelin-on-Unsplash-scaled.jpeg"),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Text(
                    field.status ?? "No status",
                    style: AppTextStyle.defaultBold(
                      color: field.status == "Good"
                          ? AppColor.primaryColor
                          : AppColor.secondaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(field.type ?? "No type",
              style: AppTextStyle.defaultBold(color: AppColor.secondaryColor)),
          const SizedBox(height: 4),
          Text(field.area ?? "No area", style: TextStyle(color: AppColor.grey)),
        ],
      ),
    );
  }
}
