import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class SetUpDropDownMenu extends StatelessWidget {
  final String title;
  final List<String> items;
  const SetUpDropDownMenu(
      {super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.defaultBold()),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius:
                BorderRadius.circular(10), // Border radius for the container
          ),
          child: DropdownButtonFormField<String>(
            value: items.isNotEmpty ? items[0] : null, // Set default value
            icon: const Icon(CupertinoIcons.chevron_down),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Apply border radius
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Apply border radius
                borderSide: BorderSide.none,
              ),
            ),
            style: AppTextStyle.defaultBold()
                .copyWith(color: Colors.black), // Set default value color
            items: <String>[...items]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppTextStyle.defaultBold(),
                ),
              );
            }).toList(),
            onChanged: (String? value) {}, // Handle selection changes
          ),
        ),
      ],
    );
  }
}
