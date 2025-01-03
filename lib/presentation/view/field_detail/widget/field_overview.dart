import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/field_information_item.dart';
import 'package:green_fairm/presentation/widget/grey_button.dart';

class FieldOverview extends StatefulWidget {
  final Field field;
  const FieldOverview({super.key, required this.field});

  @override
  State<FieldOverview> createState() => _FieldOverviewState();
}

class _FieldOverviewState extends State<FieldOverview> {
  int _slidingIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFieldName(),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _buildOverviewInformation()),
      ],
    );
  }

  Widget _buildOverviewInformation() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FieldInformationItem(
                informationType: "Crop health",
                information: widget.field.cropHealth ?? "No data",
                isExpandable: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FieldInformationItem(
                  informationType: "Planting Date",
                  information: widget.field.plantingDate ?? "No data"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: FieldInformationItem(
                  informationType: "Expenses", information: "\$2.000"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FieldInformationItem(
                  informationType: "Harvest Time",
                  information: widget.field.haverstTime ?? "No data"),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildFieldName() {
    return Row(
      children: [
        Text(
          "${widget.field.type} field",
          style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {},
          child: const Icon(
            CupertinoIcons.pencil,
            color: AppColors.secondaryColor,
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
