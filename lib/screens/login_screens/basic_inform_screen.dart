import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/buttons/next_button.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/rowlists/inform_row.dart';
import 'package:tm_front/components/rowlists/rowlist_selectable.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/controller/user_controller.dart';

class BasicInformScreen extends StatefulWidget {
  const BasicInformScreen({super.key});

  @override
  State<BasicInformScreen> createState() => _BasicInformScreenState();
}

class _BasicInformScreenState extends State<BasicInformScreen> {
  @override
  void initState() {
    super.initState();
  }

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    controller.getAllergy();
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Text('기본 정보'),
          elevation: 0,
        ),
        backgroundColor: Palette.white,
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
                  Column(
                    children: [
                      InformRow(title: '성별', formName: 'gender'),
                      InformRow(title: '생년월일', formName: 'birth'),
                      InformRow(title: '신장', formName: 'height', unit: 'cm'),
                      InformRow(title: '체중', formName: 'weight', unit: 'kg'),
                      RowListSelectable(
                        title: '알레르기',
                        formName: 'allergy',
                        buttonTitle: '선택',
                        isDivider: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 20 / 100,
                      )
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 30,
                    child: NextButton(
                      title: '다음',
                      nextPageFunc: _goNextPage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _goNextPage() {
    if (controller.userProfile.value.gender == 0) {
      showSnackBar(AlertType.error);
    } else {
      Get.toNamed('activities');
    }
  }
}
