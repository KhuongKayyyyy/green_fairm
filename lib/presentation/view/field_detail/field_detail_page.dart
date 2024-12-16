import 'package:flutter/material.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/feild_overview.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_detail_header.dart';

class FieldDetailPage extends StatefulWidget {
  final Field field;
  const FieldDetailPage({super.key, required this.field});

  @override
  State<FieldDetailPage> createState() => _FieldDetailPageState();
}

class _FieldDetailPageState extends State<FieldDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FieldDetailHeader(
              field: widget.field,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  FieldOverview(field: widget.field),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
