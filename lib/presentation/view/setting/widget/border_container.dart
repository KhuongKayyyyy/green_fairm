import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  const BorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
