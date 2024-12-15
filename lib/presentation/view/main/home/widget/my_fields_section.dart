import 'package:flutter/material.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/widget/field_small_item.dart';

class MyFieldsSection extends StatelessWidget {
  const MyFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: FakeData.fakeFields.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: FieldSmallItem(field: FakeData.fakeFields[index]),
          );
        },
      ),
    );
  }
}
