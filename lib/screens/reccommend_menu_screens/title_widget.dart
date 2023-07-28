import 'package:flutter/material.dart';

class titleWidget extends StatelessWidget {
  const titleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              titleText('일 권장 칼로리'),
              subtitleText(20),
            ],
          ),
          Column(
            children: [
              titleText('한끼 최대 칼로리'),
              subtitleText(20),
            ],
          ),
        ],
      ),
    );
  }
}

Text titleText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
    ),
  );
}

Text subtitleText(int data) {
  return Text('$data kcal');
}
