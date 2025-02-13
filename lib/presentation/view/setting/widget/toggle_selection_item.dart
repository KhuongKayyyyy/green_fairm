import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

// ignore: must_be_immutable
class ToggleSelectionItem extends StatefulWidget {
  final String title;
  final String description;
  bool? isSelected;
  final bool? isDisable;
  final Function(bool value)? onChange;

  ToggleSelectionItem({
    super.key,
    required this.title,
    required this.description,
    this.isSelected,
    this.isDisable,
    this.onChange,
  });

  @override
  State<ToggleSelectionItem> createState() => _ToggleSelectionItemState();
}

class _ToggleSelectionItemState extends State<ToggleSelectionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  widget.title,
                  style: widget.isSelected ?? false
                      ? AppTextStyle.defaultBold()
                      : AppTextStyle.defaultBold(color: AppColors.grey),
                ),
              ),
              const Spacer(),
              CupertinoSwitch(
                value: widget.isSelected ?? false,
                activeColor: AppColors.primaryColor,
                onChanged: widget.isDisable == true
                    ? null
                    : (value) {
                        setState(() {
                          widget.isSelected = value;
                        });
                        // Pass the new value to the onChange callback if it exists
                        if (widget.onChange != null) {
                          widget.onChange!(value);
                        }
                      },
              ),
            ],
          ),
          Text(
            widget.description,
            style: widget.isSelected ?? false
                ? AppTextStyle.defaultBold()
                : AppTextStyle.defaultBold(color: AppColors.grey),
          )
        ],
      ),
    );
  }
}
