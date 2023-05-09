import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Chip(
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Palette.white,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        backgroundColor: Palette.greyMain,
      ),
    );
  }
}
