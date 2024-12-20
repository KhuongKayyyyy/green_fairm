import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/widget/field_big_item.dart';

class FieldPage extends StatelessWidget {
  const FieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Field Page',
            style: AppTextStyle.defaultBold(),
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: FakeData.fakeFields.length,
            itemBuilder: (context, index) {
              return FieldBigItem(
                field: FakeData.fakeFields.elementAt(index),
              );
            }));
  }
}
