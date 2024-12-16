import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/presentation/widget/grey_button.dart';

class FieldInformationItem extends StatelessWidget {
  final String informationType;
  final String information;
  const FieldInformationItem(
      {super.key, required this.informationType, required this.information});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(informationType,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  information,
                  softWrap: true,
                ),
              ),
              const SizedBox(width: 8),
              GreyButton(
                  child: const Icon(CupertinoIcons.chevron_right),
                  onPressed: () {})
            ],
          )
        ],
      ),
    );
  }
}
