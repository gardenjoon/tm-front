import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tm_front/components/bottomtap.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/screens/check_food_screens/check_food_screen.dart';
import 'package:tm_front/screens/profile_screens/profile_screen.dart';
import 'package:tm_front/screens/reccommend_menu_screens/recommend_menu_screen.dart';
import 'package:tm_front/screens/recommend_store_screens/recommend_store_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: kIsWeb ? Palette.mainBackgroud : Palette.white,
          bottomNavigationBar: const BottomTap(),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 640),
              child: TabBarView(
                children: [
                  RecommendStoreScreen(), //TODO: 테스트용임 나중에 탭순서 바꾸기
                  RecommendMenuScreen(),
                  CheckFood(),
                  ProfileScreen(),
                ],
              ),
            ),
          )),
    );
  }
}
