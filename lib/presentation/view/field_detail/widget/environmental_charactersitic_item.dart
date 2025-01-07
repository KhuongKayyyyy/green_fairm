import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// ignore: must_be_immutable
class EnvironmentalCharactersiticItem extends StatefulWidget {
  final IconData icon;
  final String type;
  String value;
  final bool isAnimated;
  EnvironmentalCharactersiticItem({
    super.key,
    required this.icon,
    required this.type,
    required this.value,
    this.isAnimated = false,
  });

  @override
  State<EnvironmentalCharactersiticItem> createState() =>
      _EnvironmentalCharactersiticItemState();
}

class _EnvironmentalCharactersiticItemState
    extends State<EnvironmentalCharactersiticItem> {
  double valueNum = 0.0;

  @override
  void initState() {
    super.initState();
    _updateValue();
  }

  @override
  void didUpdateWidget(covariant EnvironmentalCharactersiticItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _updateValue();
    }
  }

  void _updateValue() {
    setState(() {
      valueNum = double.tryParse(widget.value) ?? 0.0;
      if (valueNum > 100) {
        valueNum = Helper.scaleToPercentageNum(valueNum.toInt(), 0, 4095);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.type,
                style: AppTextStyle.defaultBold(),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 15,
            animation: widget.isAnimated,
            arcType: ArcType.FULL,
            percent: valueNum / 100,
            arcBackgroundColor: Colors.grey.withOpacity(0.3),
            startAngle: 270,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Theme.of(context).primaryColor,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Now',
                  style: AppTextStyle.defaultBold(),
                ),
                Text(
                  "${valueNum.toStringAsFixed(0)}%",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
