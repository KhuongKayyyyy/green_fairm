import 'package:flutter/material.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/field_small_item.dart';

class MyFieldsSection extends StatefulWidget {
  final List<Field> fields;
  const MyFieldsSection({super.key, required this.fields});

  @override
  State<MyFieldsSection> createState() => _MyFieldsSectionState();
}

class _MyFieldsSectionState extends State<MyFieldsSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: widget.fields.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: FieldSmallItem(field: widget.fields[index]),
          );
        },
      ),
    );
  }
}
