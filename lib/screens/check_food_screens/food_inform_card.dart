import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class foodInformCard extends StatelessWidget {
  const foodInformCard({
    super.key,
    required this.foodInform,
    required this.isLast,
  });

  final Map foodInform;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final percent = (double.parse(foodInform['percent']) * 100).floor();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          top: 12, left: 10, right: 10, bottom: isLast ? 12 : 0),
      child: ListTile(
        horizontalTitleGap: -10,
        minVerticalPadding: 10,
        isThreeLine: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              informTitle(percent),
              Text(
                '${foodInform['calorie']} kcal',
              ),
            ],
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            informTextColumn(
                text1: '1회 제공량 : ${foodInform['total']} g',
                text2: '탄수화물 : ${foodInform['carbohydrate']} g'),
            informTextColumn(
                text1: '단백질 : ${foodInform['protein']} g',
                text2: '지방 : ${foodInform['fat']} g'),
          ],
        ),
      ),
    );
  }

  Row informTitle(int percent) {
    return Row(
      children: [
        Text(
          '${foodInform['name']} ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          decoration: BoxDecoration(
              color: percent > 70 ? Palette.main : Colors.amber[700],
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            '$percent% 일치',
            style: TextStyle(fontSize: 12, color: Palette.white),
          ),
        ),
      ],
    );
  }

  Column informTextColumn({required String text1, required String text2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
        ),
        Text(
          text2,
        ),
      ],
    );
  }
}
