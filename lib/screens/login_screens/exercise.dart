import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/components/textcomponents.dart/expand_text_button.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/screens/login_screens/picker_buttons.dart';

class ActivitiesScreen extends StatelessWidget {
  ActivitiesScreen({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text('활동량'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
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
                          '1) 평소 일과 관련된 고강도 신체 활동을 얼마나 하십니까?', 'hard'),
                      const SizedBox(height: 40),
                      titleWithPicker(
                          '2) 평소 일과 관련된 중강도 신체 활동을 얼마나 하십니까?', 'middle'),
                      const SizedBox(height: 40),
                      titleWithPickerSingle(
                          '3) 최근 일주일 동안 적어도 10분이상 걸은 날은 며칠입니까?', 'walk', 'week'),
                      const SizedBox(height: 40),
                      titleWithPickerSingle(
                          '4) 하루 동안 걷는 평균 시간은 얼마나 됩니까?', 'walk', 'day'),
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
                  child: ExpandedTextButton(
                    text: '회원가입',
                    action: _goNextPage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goNextPage() async {
    try {
      //   await controller.signUp();

      await controller.signUp().then((value) => {Get.offAllNamed('/home')});
    } catch (e) {
      print(e);
      showSnackBar(AlertType.error);
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
                    PickerButtonSingle(hardness: hardness),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('하루에  ', style: TextStyle(fontSize: 20)),
                    PickerButtonDouble(hardness: hardness),
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
              PickerButtonSingle(hardness: hardness),
              const Text('  /   ', style: TextStyle(fontSize: 20)),
              const Text('하루에  ', style: TextStyle(fontSize: 20)),
              PickerButtonDouble(hardness: hardness),
            ],
          )
        ],
      ),
    );
  }
}
