import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/controller/user_controller.dart';

class PickerButtonSingle extends StatelessWidget {
  PickerButtonSingle({super.key, required this.hardness});

  final hardness;
  final UserController controller = Get.put(UserController());
  final List<int> daysList = List.generate(8, (i) => i).toList();

  @override
  Widget build(BuildContext context) {
    return Obx(() => CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.bottomSheet(
            Container(
              height: 240,
              constraints: const BoxConstraints(maxWidth: 640),
              child: CupertinoPicker(
                  //   magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: false,
                  itemExtent: 50,
                  onSelectedItemChanged: (int index) {
                    controller.selectExercise(hardness).days = daysList[index];
                    controller.exerciseData.refresh();
                  },
                  children: [
                    ...daysList.map((value) {
                      return Center(
                        child: Text(
                          '$value 일',
                        ),
                      );
                    })
                  ]),
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(
            '${controller.selectExercise(hardness).days} 일',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ));
  }
}

class PickerButtonDouble extends StatelessWidget {
  PickerButtonDouble({super.key, required this.hardness});

  final hardness;
  final UserController controller = Get.put(UserController());

  final List<int> hoursList = List.generate(25, (i) => i).toList();
  final List<int> minutesList = [0, 10, 20, 30, 40, 50];

  @override
  Widget build(BuildContext context) {
    return Obx(() => CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.bottomSheet(
            SizedBox(
              height: 240,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                        // magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: false,
                        itemExtent: 50,
                        onSelectedItemChanged: (int index) {
                          controller.selectExercise(hardness).hours =
                              hoursList[index];
                          controller.exerciseData.refresh();
                        },
                        children: [
                          ...hoursList.map((value) {
                            return Center(
                              child: Text(
                                '$value 시간',
                              ),
                            );
                          })
                        ]),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                        //   magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: false,
                        itemExtent: 50,
                        onSelectedItemChanged: (int index) {
                          controller.selectExercise(hardness).minutes =
                              minutesList[index];
                          controller.exerciseData.refresh();
                        },
                        children: [
                          ...minutesList.map((value) {
                            return Center(
                              child: Text(
                                '$value 분',
                              ),
                            );
                          })
                        ]),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(
            '${controller.selectExercise(hardness).hours} 시간  ${controller.selectExercise(hardness).minutes} 분',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ));
  }
}
