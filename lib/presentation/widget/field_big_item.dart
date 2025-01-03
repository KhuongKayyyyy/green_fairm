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
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Hero(
                  tag: "fieldImage${field.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      field.imageUrl!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          field.name!,
                          style: AppTextStyle.defaultBold(),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.grey,
                              size: 15,
                            ),
                            Text(
                              field.area!,
                              style: AppTextStyle.defaultBold(
                                  color: AppColors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.lightbg.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        field.status ?? 'Good',
                        style: AppTextStyle.defaultBold(
                            color: AppColors.primaryColor),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
