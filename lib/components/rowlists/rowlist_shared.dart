import 'package:flutter/material.dart';

const double vertPad = 16;
const double horiPad = 20;

class RowListTitle extends StatelessWidget {
  const RowListTitle({
    super.key,
    required this.title,
    this.isPad = true,
  });

  final String title;
  final bool isPad;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: vertPad,
          bottom: isPad ? vertPad : 0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
          ),
        ));
  }
}
