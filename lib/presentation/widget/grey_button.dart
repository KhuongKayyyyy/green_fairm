import 'package:flutter/material.dart';

class GreyButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  const GreyButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: child,
        ));
  }
}
