import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/screens/check_food_screens/food_inform_card.dart';

class FoodInformBox extends StatelessWidget {
  const FoodInformBox({
    super.key,
    required this.predictions,
    required this.sum,
  });

  final RxList predictions;
  final RxInt sum;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          color: Palette.greySub3,
          child: ListView.builder(
            itemCount: predictions.length + 1,
            itemBuilder: (context, index) {
              if (index < predictions.length) {
                return foodInformCard(
                  foodInform: predictions[index],
                  isLast: index == predictions.length - 1
                      ? true
                      : false,
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(
                      top: 12,
                      left: 10,
                      right: 10,
                      bottom: 12),
                  decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius:
                          BorderRadius.circular(10)),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '총 칼로리',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$sum kcal',
                          style: TextStyle(
                            fontSize: 20,
                            //   fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
  }
}
