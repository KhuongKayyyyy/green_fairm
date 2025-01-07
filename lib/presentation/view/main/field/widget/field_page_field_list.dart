import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/field_big_item.dart';

class FieldPageFieldList extends StatefulWidget {
  final List<Field> fields;
  const FieldPageFieldList({super.key, required this.fields});

  @override
  State<FieldPageFieldList> createState() => _FieldPageFieldListState();
}

class _FieldPageFieldListState extends State<FieldPageFieldList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Your Fields",
                style: AppTextStyle.defaultBold(color: AppColors.white)),
            const Spacer(),
            Text(
              "${widget.fields.length} fields",
              style: AppTextStyle.defaultBold(color: AppColors.accentColor),
            )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 150),
              itemCount: widget.fields.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FieldBigItem(
                    field: widget.fields[index],
                  ),
                );
              },
            )),
      ],
    );
  }
}
