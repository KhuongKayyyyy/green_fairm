import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/app_search_bar.dart';

class FieldPageHeader extends StatefulWidget {
  final List<Field> fields;
  const FieldPageHeader({super.key, required this.fields});

  @override
  State<FieldPageHeader> createState() => _FieldPageHeaderState();
}

class _FieldPageHeaderState extends State<FieldPageHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Hello, ",
                        style: AppTextStyle.mediumBold(color: AppColors.white)),
                    TextSpan(
                        text:
                            "${FirebaseAuth.instance.currentUser!.displayName}",
                        style: AppTextStyle.mediumBold(
                            color: AppColors.accentColor)),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  context.pushNamed(Routes.addNewField);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentColor,
                  ),
                  child: const Icon(Icons.add, color: AppColors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          AppSearchBar(
            fields: widget.fields,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
