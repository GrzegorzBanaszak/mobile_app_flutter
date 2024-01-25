import 'package:flutter/material.dart';
import 'package:mobile_app/utilis/my_colors.dart';

class Circle extends StatelessWidget {
  const Circle({required this.size, required this.color, super.key});
  final double size;
  final String color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999999),
        color: HexColor(color),
      ),
    );
  }
}
