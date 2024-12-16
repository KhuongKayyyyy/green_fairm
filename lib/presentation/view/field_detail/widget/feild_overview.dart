import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/field_information_item.dart';
import 'package:green_fairm/presentation/widget/grey_button.dart';

class FieldOverview extends StatelessWidget {
  final Field field;
  const FieldOverview({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFieldName(),
        // _buildOverviewInformation()
      ],
    );
  }

  Widget _buildOverviewInformation() {
    return Column(
      children: [
        Flexible(
          child: Row(
            children: [
              FieldInformationItem(
                  informationType: "Crop heath", information: "Good"),
              FieldInformationItem(
                  informationType: "Crop heath", information: "Good"),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildFieldName() {
    return Row(
      children: [
        Text(
          "${field.type} field",
          style: AppTextStyle.mediumBold(color: AppColor.secondaryColor),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {},
          child: const Icon(
            CupertinoIcons.pencil,
            color: AppColor.secondaryColor,
            size: 25,
          ),
        ),
        const Spacer(),
        GreyButton(
            child: const Row(
              children: [
                Text("More detail"),
                SizedBox(width: 5),
                Icon(
                  CupertinoIcons.chevron_right,
                  size: 20,
                )
              ],
            ),
            onPressed: () {})
      ],
    );
  }
}
