import 'package:flutter/material.dart';

const double vertPad = 16;
const double horiPad = 20;

class RowListTitle extends StatelessWidget {
  final int index;
  const RowListTitle({
    super.key,
    required this.index,
    required this.titleList,
    this.isPad = true,
  });

  final List<String> titleList;
  final bool isPad;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            // left: horiPad,
            // right: horiPad,
            top: vertPad,
            bottom: isPad ? vertPad : 0),
        child: Text(
          titleList[index],
          style: const TextStyle(
            fontSize: 22,
          ),
        ));
  }
}
