import 'package:flutter/material.dart';

class ActionButtonIcon extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  final bool? isGreen;
  const ActionButtonIcon(
      {super.key, required this.icon, this.onPressed, this.isGreen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isGreen == true
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ));
  }
}
