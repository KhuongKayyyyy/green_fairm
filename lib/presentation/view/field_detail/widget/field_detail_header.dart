import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';

class FieldDetailHeader extends StatelessWidget {
  final Field field;
  const FieldDetailHeader({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "fieldImage${field.id}",
          child: Image.network(
            height: MediaQuery.of(context).size.height * 0.4,
            field.imageUrl ?? AppImage.placeholder,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 50,
            left: 20,
            child: ActionButtonIcon(
                icon: Icons.arrow_back, onPressed: () => context.pop())),
        Positioned(
            bottom: 20,
            right: 20,
            child: ActionButtonIcon(
                icon: CupertinoIcons.arrow_up_left_arrow_down_right,
                onPressed: () => context.pop())),
      ],
    );
  }
}
