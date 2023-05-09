import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class InformTexts extends StatelessWidget {
  const InformTexts({super.key, required this.title, required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Palette.main,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
