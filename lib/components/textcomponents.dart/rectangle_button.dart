import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class RectangleButton extends StatelessWidget {
  final Function()? callback;
  final String title;
  const RectangleButton({
    super.key,
    required this.callback,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
          onPressed: callback,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Palette.main,
          ),
          child: Text(title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}
