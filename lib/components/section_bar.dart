import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

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

class RowDivider extends StatelessWidget {
  const RowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: 8, color: Palette.greySub3);
  }
}
