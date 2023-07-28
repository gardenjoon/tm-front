import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/models/menu.dart';

import 'package:tm_front/services/menu_service.dart';

class RcmdMenuController extends GetxController {
  late MenuRepository _menuRepository;

  //selectWidget 부분
  RxList<MenuSet> menuSet = <MenuSet>[].obs;

  RxMap menuStyles = {'한식': false, '중식': false, '일식': false, '양식': false}.obs;
  RxMap tags = {
    '매콤': false,
    '고단백': false,
    '저칼로리': false,
    '저지방': false,
    '저염': false,
    '저당': false,
    '채소류': false,
    '육류': false,
    '해산물': false,
    '밀가루': false,
    '달콤': false,
    '짠': false,
    '따뜻한': false,
  }.obs;
  RxInt defaultCalorie = 700.obs;
  RxInt calorie = 0.obs;
  RxBool toggledGetMenu = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _menuRepository = MenuRepository();
    calorie.value = defaultCalorie.value;
  }

  void saveCalorie(int value) {
    calorie.value = value;
  }

  void toggleTag(String text) {
    tags[text] = !tags[text];
  }

  void toggleStyle(String title) {
    menuStyles[title] = !menuStyles[title];
  }

  void resetAll() {
    menuStyles.forEach(
        (key, value) => value == true ? menuStyles[key] = false : null);
    tags.forEach((key, value) => value == true ? tags[key] = false : null);
  }

  void changeMenu({
    required int menuSetIndex,
    required int oldMenuIndex,
    required int newMenuIndex,
  }) {
    menuSet[menuSetIndex].menus[oldMenuIndex] = singleMenuList[newMenuIndex];
    for (var element in menuSet) {
      var totalTags = [];
      var total_calorie = 0.0;
      for (var menu in element.menus) {
        for (var tag in menu.tags) {
          if (!totalTags.contains(tag)) totalTags.add(tag);
        }
        total_calorie += double.parse(menu.total_cal);
      }

      menuSet[menuSetIndex].total_calorie = total_calorie.toInt();
      menuSet[menuSetIndex].tags = totalTags;
    }
    update();
  }

  void loadMenu() async {
    toggledGetMenu.value = !toggledGetMenu.value;
    if (toggledGetMenu.value == false) {
      final _userController = Get.put(UserController());
      await _userController.getProfile();

      try {
        var menus;
        if (trueMapToList(menuStyles).isNotEmpty) {
          isLoading.value = true;
          menus = await _menuRepository
              .getMenu(
                id: _userController.userId.value,
                styles: trueMapToJson(menuStyles),
                tags: trueMapToJson(tags),
                calorie:
                    calorie.value > 0 ? calorie.value : defaultCalorie.value,
              )
              .timeout(Duration(seconds: 30));
        } else {
          menus = await _menuRepository
              .getMenu(
                id: _userController.userId.value,
                styles: jsonEncode([]),
                tags: trueMapToJson(tags),
                calorie:
                    calorie.value > 0 ? calorie.value : defaultCalorie.value,
              )
              .timeout(Duration(seconds: 5));
        }
        if (menus == []) {
          throw Exception('데이터 없음');
        }
        isLoading.value = false;
        menuSet.value = menus;
      } on TimeoutException {
        showSnackBar(AlertType.error);
        toggledGetMenu.value = true;
        isLoading.value = false;
      } on Exception {
        showSnackBar(AlertType.error, text: '조건에 맞는 식단을 불러오지 못했습니다');
      }
    }
  }

  // chooseWidget 부분

  RxList<Menu> singleMenuList = [
    Menu(
        food_id: 'mn205',
        fodgrp_cd: 5,
        src: 'es',
        food_nm: '현미밥, 쌀',
        total_amt: '190.00',
        total_cal: '228.70',
        total_carbo: '49.16',
        total_prot: '4.29',
        total_fat: '0.74',
        total_na: '1.84',
        total_sugar: '0.28',
        sty_kr: '0.5',
        sty_cn: '0.0',
        sty_jp: '0.5',
        sty_ws: '0.0',
        lv_spicy: 0,
        hg_prot: 0,
        lw_cal: 0,
        lv_fat: 2,
        lv_na: 2,
        lv_su: 2,
        vegetable: 1,
        meat: 0,
        seafood: 0,
        tags: ['저지방', '저염', '저당', '채소류']),
    Menu(
      food_id: 'mn049',
      fodgrp_cd: 12,
      src: 'res',
      food_nm: '돼지고기찌개',
      total_amt: '360.00',
      total_cal: '203.85',
      total_carbo: '9.87',
      total_prot: '14.74',
      total_fat: '11.31',
      total_na: '549.55',
      total_sugar: '2.32',
      sty_kr: '1.0',
      sty_cn: '0.0',
      sty_jp: '0.0',
      sty_ws: '0.0',
      lv_spicy: 0,
      hg_prot: 1,
      lw_cal: 0,
      lv_fat: 0,
      lv_na: 0,
      lv_su: 1,
      vegetable: 0,
      meat: 1,
      seafood: 0,
      tags: ['고단백', '저당', '육류'],
    ),
    Menu(
      food_id: 'mn255',
      fodgrp_cd: 13,
      src: 'es',
      food_nm: '닭찜, 간장',
      total_amt: '150.00',
      total_cal: '151.28',
      total_carbo: '12.41',
      total_prot: '12.40',
      total_fat: '5.47',
      total_na: '267.74',
      total_sugar: '2.74',
      sty_kr: '1.0',
      sty_cn: '0.0',
      sty_jp: '0.0',
      sty_ws: '0.0',
      lv_spicy: 0,
      hg_prot: 1,
      lw_cal: 0,
      lv_fat: 0,
      lv_na: 0,
      lv_su: 1,
      vegetable: 0,
      meat: 1,
      seafood: 0,
      tags: ['고단백', '저당', '육류'],
    ),
    Menu(
      food_id: 'mn117',
      fodgrp_cd: 6,
      src: 'res',
      food_nm: '감자볶음, 당근',
      total_amt: '90.00',
      total_cal: '42.37',
      total_carbo: '7.01',
      total_prot: '0.97',
      total_fat: '1.24',
      total_na: '107.91',
      total_sugar: '0.38',
      sty_kr: '1.0',
      sty_cn: '0.0',
      sty_jp: '0.0',
      sty_ws: '0.0',
      lv_spicy: 0,
      hg_prot: 0,
      lw_cal: 0,
      lv_fat: 1,
      lv_na: 1,
      lv_su: 2,
      vegetable: 1,
      meat: 0,
      seafood: 0,
      tags: ['저지방', '저염', '저당', '채소류'],
    )
  ].obs;
}

List trueMapToList(Map param) {
  var trueList = <String>[];
  param.forEach((key, value) => value == true ? trueList.add(key) : null);
  return trueList;
}

String trueMapToJson(Map param) {
  var trueList = <String>[];
  param.forEach((key, value) => value == true ? trueList.add(key) : null);
  return jsonEncode(trueList);
}
