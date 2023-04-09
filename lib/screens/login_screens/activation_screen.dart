import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final List<int> daysList = List.generate(8, (i) => i).toList();
  final List<int> hoursList = List.generate(25, (i) => i).toList();
  final List<int> minutesList = [0, 10, 20, 30, 40, 50];

  final _hardTimes = {
    'days': 0,
    'hours': 0,
    'minutes': 0,
  }.obs;
  final _softTimes = {
    'days': 0,
    'hours': 0,
    'minutes': 0,
  }.obs;
  final _walkTimes = {
    'days': 0,
    'hours': 0,
    'minutes': 0,
  }.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text("활동량"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Palette.greySub2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            activityInform('고강도 활동',
                                '- 격렬한 신체 활동으로 숨이 많이 차거나 심장이 매우 빠르게 뛰는 활동'),
                            const SizedBox(height: 10),
                            activityInform('중강도 활동',
                                '- 중간 정도의 신체 활동으로 숨이 약간 차거나 심장이 약간 빠르게 뛰는 활동'),
                          ],
                        ),
                      ),
                      titleWithPicker(
                          "1) 평소 일과 관련된 고강도 신체 활동을 얼마나 하십니까?", 'hard'),
                      const SizedBox(height: 40),
                      titleWithPicker(
                          "2) 평소 일과 관련된 중강도 신체 활동을 얼마나 하십니까?", 'soft'),
                      const SizedBox(height: 40),
                      titleWithPickerSingle(
                          "3) 최근 일주일 동안 적어도 10분이상 걸은 날은 며칠입니까?",
                          'walk',
                          'week'),
                      const SizedBox(height: 40),
                      titleWithPickerSingle(
                          "4) 하루 동안 걷는 평균 시간은 얼마나 됩니까?", 'walk', 'day'),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: TextButton(
                                onPressed: () => Get.offAllNamed('profile'),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  backgroundColor: Palette.main,
                                ),
                                child: const Text('회원가입 완료',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox activityInform(String title, String explain) {
    return SizedBox(
      width: 640,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Palette.main,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  explain,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox titleWithPickerSingle(String title, String hardness, String single) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          single == 'week'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('일주일에 ', style: TextStyle(fontSize: 20)),
                    Obx(() => pickerButtonSingle(hardness)),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('하루에  ', style: TextStyle(fontSize: 20)),
                    Obx(() => pickerButtonDouble(hardness)),
                  ],
                )
        ],
      ),
    );
  }

  SizedBox titleWithPicker(String title, String hardness) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('일주일에 ', style: TextStyle(fontSize: 20)),
              Obx(() => pickerButtonSingle(hardness)),
              const Text('  /   ', style: TextStyle(fontSize: 20)),
              const Text('하루에  ', style: TextStyle(fontSize: 20)),
              Obx(() => pickerButtonDouble(hardness)),
            ],
          )
        ],
      ),
    );
  }

  CupertinoButton pickerButtonSingle(String hardness) {
    RxMap selectNum() {
      if (hardness == 'hard') {
        return _hardTimes;
      } else if (hardness == 'soft') {
        return _softTimes;
      } else {
        return _walkTimes;
      }
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => Get.bottomSheet(
        SizedBox(
          height: 240,
          child: CupertinoPicker(
              //   magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: false,
              itemExtent: 50,
              onSelectedItemChanged: (int index) {
                setState(() {});
                // ignore: invalid_use_of_protected_member
                selectNum().value['days'] = daysList[index];
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
        // ignore: invalid_use_of_protected_member
        '${selectNum().value['days']} 일',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  CupertinoButton pickerButtonDouble(String hardness) {
    RxMap selectNum() {
      if (hardness == 'hard') {
        return _hardTimes;
      } else if (hardness == 'soft') {
        return _softTimes;
      } else {
        return _walkTimes;
      }
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => Get.bottomSheet(
        SizedBox(
          height: 240,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPicker(
                    //   magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: false,
                    itemExtent: 50,
                    onSelectedItemChanged: (int index) {
                      setState(() {});
                      // ignore: invalid_use_of_protected_member
                      selectNum().value['hours'] = hoursList[index];
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
                      setState(() {});
                      // ignore: invalid_use_of_protected_member
                      selectNum().value['minutes'] = minutesList[index];
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
        // ignore: invalid_use_of_protected_member
        '${selectNum().value['hours']} 시간  ${selectNum().value['minutes']} 분',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
