import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';

enum AlertType {
  success('success', '성공'),
  info('info', '안내'),
  error('error', '에러'),
  undefined('undefined', '');

  const AlertType(this.code, this.displayName);
  final String code;
  final String displayName;

  factory AlertType.getByCode(String code) {
    return AlertType.values.firstWhere((value) => value.code == code,
        orElse: () => AlertType.undefined);
  }
}

void showSnackBar(AlertType type, {String? text}) {
  if (type == AlertType.error) {
    Get.snackbar(
      '에러',
      text ?? '서버 에러입니다. 관리자에게 문의하십시오',
      backgroundColor: Color.fromRGBO(255, 82, 82, 0.8),
      colorText: Palette.white,
      icon: const Icon(
        CupertinoIcons.exclamationmark_circle,
        color: Palette.greySub2,
        size: 40,
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      shouldIconPulse: false,
    );
  }
  if (type == AlertType.info) {
    Get.snackbar(
      '정보',
      text ?? '',
      backgroundColor: Color.fromRGBO(92, 116, 221, 0.8),
      colorText: Palette.white,
      icon: const Icon(
        CupertinoIcons.exclamationmark_circle,
        color: Palette.greySub2,
        size: 40,
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      shouldIconPulse: false,
    );
  }
  ;
}
