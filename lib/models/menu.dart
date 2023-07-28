class Menu {
  final String food_id;
  final int fodgrp_cd;
  final String src;
  final String food_nm;
  final String total_amt;
  final String total_cal;
  final String total_carbo;
  final String total_prot;
  final String total_fat;
  final String total_na;
  final String total_sugar;
  final String sty_kr;
  final String sty_cn;
  final String sty_jp;
  final String sty_ws;
  final int lv_spicy;
  final dynamic hg_prot;
  final dynamic lw_cal;
  final dynamic lv_fat;
  final dynamic lv_na;
  final dynamic lv_su;
  final int vegetable;
  final int meat;
  final int seafood;
  final List tags;

  Menu({
    required this.food_id,
    required this.fodgrp_cd,
    required this.src,
    required this.food_nm,
    required this.total_amt,
    required this.total_cal,
    required this.total_carbo,
    required this.total_prot,
    required this.total_fat,
    required this.total_na,
    required this.total_sugar,
    required this.sty_kr,
    required this.sty_cn,
    required this.sty_jp,
    required this.sty_ws,
    required this.lv_spicy,
    required this.hg_prot,
    required this.lw_cal,
    required this.lv_fat,
    required this.lv_na,
    required this.lv_su,
    required this.vegetable,
    required this.meat,
    required this.seafood,
    required this.tags,
  });

  Menu.fromJson(Map<dynamic, dynamic> json)
      : food_id = json['food_id'],
        fodgrp_cd = json['fodgrp_cd'],
        src = json['src'],
        food_nm = json['food_nm'],
        total_amt = json['total_amt'],
        total_cal = json['total_cal'],
        total_carbo = json['total_carbo'],
        total_prot = json['total_prot'],
        total_fat = json['total_fat'],
        total_na = json['total_na'],
        total_sugar = json['total_sugar'],
        sty_kr = json['sty_kr'],
        sty_cn = json['sty_cn'],
        sty_jp = json['sty_jp'],
        sty_ws = json['sty_ws'],
        lv_spicy = json['lv_spicy'],
        hg_prot = json['hg_prot'],
        lw_cal = json['lw_cal'],
        lv_fat = json['lv_fat'],
        lv_na = json['lv_na'],
        lv_su = json['lv_su'],
        vegetable = json['vegetable'],
        meat = json['meat'],
        seafood = json['seafood'],
        tags = json['tags'];
}

List makeTagList({required Menu menu}) {
  var tagList = [];

  menu.lv_spicy > 0 ? tagList.add('매콤') : null;
  menu.hg_prot > 0 ? tagList.add('고단백') : null;
  menu.lw_cal > 0 ? tagList.add('저칼로리') : null;
  menu.lv_fat > 0 ? tagList.add('저지방') : null;
  menu.lv_na > 0 ? tagList.add('저염') : null;
  menu.lv_su > 0 ? tagList.add('저당') : null;
  menu.vegetable > 0 ? tagList.add('채소류') : null;
  menu.meat > 0 ? tagList.add('육류') : null;
  menu.seafood > 0 ? tagList.add('해산물') : null;

  return tagList;
}

class MenuSet {
  final String style;
  int total_calorie;
  List<dynamic> tags;
  final List<Menu> menus;

  MenuSet.fromJson(Map<String, dynamic> json)
      : style = json['style'] as String,
        total_calorie = json['total_calorie'] as int,
        tags = json['tags'],
        menus = List<dynamic>.from(json['menus'])
            .map((e) => Menu.fromJson(e))
            .toList();
}
