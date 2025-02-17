import 'package:flutter/material.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/field_small_item.dart';

class MyFieldsSection extends StatefulWidget {
  final List<Field> fields;
  const MyFieldsSection({super.key, required this.fields});

  @override
  State<MyFieldsSection> createState() => _MyFieldsSectionState();
}

class _MyFieldsSectionState extends State<MyFieldsSection> {
  var controller = PageController(viewportFraction: 0.45);

  void deleteField(int index) {
    setState(() {
      widget.fields.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: PageView.builder(
        padEnds: false,
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.fields.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: index == widget.fields.length - 1 ? 15 : 0,
            ),
            child: FieldSmallItem(
              key: ValueKey(widget.fields[index].id),
              field: widget.fields[index],
              onDelete: () => deleteField(index), // Pass the callback
            ),
          );
        },
      ),
    );
  }
}
