import 'package:flutter/material.dart';
import 'package:tm_front/components/bottomtap.dart';
import 'package:tm_front/screens/check_food_screen.dart';
import 'package:tm_front/screens/profile_screens/profile_screen.dart';
import 'package:tm_front/screens/recommend_menu_screen.dart';
import 'package:tm_front/screens/recommend_store_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const BottomTap(),
          body: TabBarView(
            children: [
              const RecommendMenuScreen(),
              RecommendStoreScreen(),
              CheckFood(),
              ProfileScreen(),
            ],
          )),
    );
  }
}
