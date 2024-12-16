import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/model/field.dart';

class FieldSmallItem extends StatelessWidget {
  final Field field;
  const FieldSmallItem({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.fieldDetail, extra: field);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: "fieldImage${field.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        width: double.infinity,
                        field.imageUrl ?? AppImage.placeholder),
                  ),
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
                style:
                    AppTextStyle.defaultBold(color: AppColor.secondaryColor)),
            const SizedBox(height: 4),
            Text(field.area ?? "No area",
                style: TextStyle(color: AppColor.grey)),
          ],
        ),
      ),
    );
  }
}
