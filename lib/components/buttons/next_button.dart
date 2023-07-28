import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class NextButton extends StatelessWidget {
  final dynamic nextPageFunc;
  final String title;
  const NextButton({
    super.key,
    required this.title,
    required this.nextPageFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: TextButton(
                onPressed: nextPageFunc,
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
                      fontWeight: FontWeight.bold,
                    ))),
          ),
        ),
      ],
    );
  }
}
