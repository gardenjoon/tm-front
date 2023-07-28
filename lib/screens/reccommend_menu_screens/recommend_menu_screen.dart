import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/loading_indicator.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/controller/rcmd_menu_controller.dart';
import 'package:tm_front/screens/reccommend_menu_screens/choose_widget.dart';
import 'package:tm_front/screens/reccommend_menu_screens/select_widget.dart';

class RecommendMenuScreen extends StatelessWidget {
  RecommendMenuScreen({super.key});

  final RcmdMenuController controller = Get.put(RcmdMenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.greySub2,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Text(
            '추천식단',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: Obx(
              () => Stack(
                children: [
                  controller.isLoading.value
                      ? Positioned.fill(
                          child: Container(
                            child: LoadingIndicator(
                              loadingTextWidget: Text('데이터를 불러오는 중입니다'),
                            ),
                          ),
                        )
                      : Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Column(
                            children: [
                              Container(height: 100),
                              ChooseWidget(),
                            ],
                          ),
                        ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: SelectWidget(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
