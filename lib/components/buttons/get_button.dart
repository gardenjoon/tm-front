import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class getButton extends StatelessWidget {
  const getButton({
    super.key,
    required this.title,
    required this.func,
    this.height = 40,
  });

  final String title;
  final double? height;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: height,
        child: TextButton(
            onPressed: func,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              backgroundColor: Palette.main,
            ),
            child: Text(title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ))),
      ),
    );
  }
}
