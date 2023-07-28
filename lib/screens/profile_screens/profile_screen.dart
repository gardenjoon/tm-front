import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/buttons/next_button.dart';
import 'package:tm_front/components/rowlists/inform_row.dart';
import 'package:tm_front/components/rowlists/rowlist_selectable.dart';
import 'package:tm_front/components/section_bar.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/screens/login_screens/picker_buttons.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    controller.getAllergy();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: FutureBuilder(
                future: controller.getProfile(),
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      ProfileAppBar(),
                      const RowDivider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            InformRow(title: '성별', formName: 'gender'),
                            InformRow(title: '생년월일', formName: 'birth'),
                            InformRow(
                                title: '신장', formName: 'height', unit: 'cm'),
                            InformRow(
                                title: '체중', formName: 'weight', unit: 'kg'),
                            RowListSelectable(
                              title: '알레르기',
                              formName: 'allergy',
                              buttonTitle: '선택',
                              isDivider: false,
                            ),
                          ],
                        ),
                      ),
                      const RowDivider(),
                      titleWithPicker('고강도 신체활동', 'hard'),
                      titleWithPicker('중강도 신체활동', 'middle'),
                      titleWithPicker('걷기활동', 'walk'),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: NextButton(
                          title: '업데이트',
                          nextPageFunc: updateFunc,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }

  void updateFunc() async {
    await controller.updateProfile().then(
        (value) => showSnackBar(AlertType.info, text: '성공적으로 업데이트 되었습니다'));
  }

  SizedBox titleWithPicker(String title, String hardness) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20, top: 14),
              child: Text(title, style: const TextStyle(fontSize: 20))),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('일주일에 ', style: TextStyle(fontSize: 18)),
              PickerButtonSingle(hardness: hardness),
              const Text('  /   ', style: TextStyle(fontSize: 18)),
              const Text('하루에  ', style: TextStyle(fontSize: 18)),
              PickerButtonDouble(hardness: hardness),
            ],
          )
        ],
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  ProfileAppBar({
    super.key,
  });

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                controller.userProfile.value.user_name,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Icon(Icons.settings_rounded, size: 32)),
          ],
        ));
  }
}
