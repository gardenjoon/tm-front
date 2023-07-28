import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class ExpandedTextButton extends StatelessWidget {
  const ExpandedTextButton({
    super.key,
    required this.text,
    required this.action,
    this.textColor = Colors.white,
    this.backgroundColor = Palette.main,
    this.useBorder = false,
    this.height = 60,
  });

  final String text;
  final action;
  final Color textColor;
  final Color backgroundColor;
  final bool useBorder;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: height,
            child: TextButton(
                onPressed: action,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                    side: useBorder
                        ? BorderSide(width: 1.6, color: Palette.greySub)
                        : BorderSide(width: 0),
                  ),
                  backgroundColor: backgroundColor,
                ),
                child: Text(text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ))),
          ),
        ),
      ],
    );
  }
}
