class MenuModel {
  final String foodGropCd;
  final String fiNm;
  final String prtin;
  final String gely;
  final String cbhdt;
  final String cal;
  final String totlPrtn;

  MenuModel.fromJson(Map<dynamic, dynamic> json)
      : foodGropCd = json['food_grop_cd'],
        fiNm = json['fi_nm'],
        prtin = json['prtin'],
        gely = json['gely'],
        cbhdt = json['cbhdt'],
        cal = json['cal'],
        totlPrtn = json['totl_prtn'];
}