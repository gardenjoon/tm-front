import 'package:flutter/material.dart';

class SectionBar extends StatelessWidget {
  const SectionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      height: 1,
      color: Colors.black,
    );
  }
}
