import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class BottomTap extends StatelessWidget {
  const BottomTap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 640),
        height: 60,
        width: 640,
        decoration: const BoxDecoration(
            color: Palette.white,
            border: Border(
                top: BorderSide(
              color: Palette.greySub2,
              width: 1,
            ))),
        child: TabBar(
          overlayColor: MaterialStateProperty.all(const Color(0x00000000)),
          labelColor: Palette.main,
          indicatorColor: Palette.transparent,
          unselectedLabelColor: Palette.greySub,
          labelStyle: const TextStyle(fontSize: 14),
          tabs: [
            customTab('추천식단', const Icon(Icons.star, size: 24)),
            customTab('주변식당', const Icon(Icons.location_on, size: 24)),
            customTab(
                '식단정보', const Icon(CupertinoIcons.photo_camera, size: 24)),
            customTab(
                '내 정보', const Icon(Icons.account_circle_rounded, size: 24)),
          ],
        ),
      ),
    );
  }

  Widget customTab(
    String title,
    Widget icon,
  ) {
    return Tab(
      icon: icon,
      text: title,
      iconMargin: const EdgeInsets.only(bottom: 5),
    );
  }
}
