import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tm_front/components/next_button.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/textcomponents.dart/picker_button.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/services/login_service.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final List<int> daysList = List.generate(8, (i) => i).toList();
  final List<int> hoursList = List.generate(25, (i) => i).toList();
  final List<int> minutesList = [0, 10, 20, 30, 40, 50];

  final _activityData = Get.put(ActivityData());

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 640),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
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
                    const SizedBox(height: 20),
                    titleWithPicker(
                        "1) 평소 일과 관련된 고강도 신체 활동을 얼마나 하십니까?", 'hard'),
                    const SizedBox(height: 40),
                    titleWithPicker(
                        "2) 평소 일과 관련된 중강도 신체 활동을 얼마나 하십니까?", 'soft'),
                    const SizedBox(height: 40),
                    titleWithPickerSingle(
                        "3) 최근 일주일 동안 적어도 10분이상 걸은 날은 며칠입니까?", 'walk', 'week'),
                    const SizedBox(height: 40),
                    titleWithPickerSingle(
                        "4) 하루 동안 걷는 평균 시간은 얼마나 됩니까?", 'walk', 'day'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 20 / 100,
                    )
                  ],
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: NextButton(
                  title: '회원가입 완료',
                  nextPageFunc: _goNextPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _goNextPage() async {
    try {
      final result = await LoginService.signUp();
      final storeUserId = GetStorage();

      if (result.contains('exists')) {
        if (!mounted) return;
        showSnackBar(context, '같은 ID의 사용자가 이미 존재합니다.');
      } else if (result != false) {
        storeUserId.write('userId', result);
        Get.offAllNamed('home');
      } else {
        if (!mounted) return;
        showSnackBar(context, 'server');
      }
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, 'server');
    }
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
                    pickerButtonSingle(hardness),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('하루에  ', style: TextStyle(fontSize: 20)),
                    pickerButtonDouble(hardness),
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
              pickerButtonSingle(hardness),
              const Text('  /   ', style: TextStyle(fontSize: 20)),
              const Text('하루에  ', style: TextStyle(fontSize: 20)),
              pickerButtonDouble(hardness),
            ],
          )
        ],
      ),
    );
  }

  selectNum(hardness) {
    if (hardness == 'hard') {
      return _activityData.data['hardTimes'];
    } else if (hardness == 'soft') {
      return _activityData.data['softTimes'];
    } else {
      return _activityData.data['walkTimes'];
    }
  }

  CupertinoButton pickerButtonSingle(String hardness) {
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
                selectNum(hardness)['days'] = daysList[index];
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
        '${selectNum(hardness)['days']} 일',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  CupertinoButton pickerButtonDouble(String hardness) {
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
                      selectNum(hardness)['hours'] = hoursList[index];
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
                      selectNum(hardness)['minutes'] = minutesList[index];
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
        '${selectNum(hardness)['hours']} 시간  ${selectNum(hardness)['minutes']} 분',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
