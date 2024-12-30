import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/app_navigation.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/model/field.dart';

class FieldBigItem extends StatelessWidget {
  final Field field;
  const FieldBigItem({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.fieldDetail, extra: field);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: "fieldImage${field.id}",
                    child: Image.network(
                      field.imageUrl!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        field.name!,
                        style: AppTextStyle.mediumBold(
                            color: AppColor.secondaryColor),
                      ),
                      Text(
                        "${field.type!}field",
                        style: AppTextStyle.defaultBold(
                            color: const Color.fromARGB(255, 95, 55, 55)),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Text(
                      field.status!,
                      style: AppTextStyle.defaultBold(
                        color: field.status!.toLowerCase() == 'good'
                            ? AppColor.primaryColor
                            : AppColor.secondaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColor.primaryColor,
                ),
                SizedBox(width: 10),
                Text(
                  "Thốt Nốt, Cần Thơ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
