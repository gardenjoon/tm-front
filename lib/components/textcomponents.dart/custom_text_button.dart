import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.action,
    this.color = Colors.black,
  });

  final String text;
  final action;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: action,
        child: Text(
          text,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
