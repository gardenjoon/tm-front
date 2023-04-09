import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/screens/check_food_screen.dart';
import 'package:tm_front/screens/profile_screen.dart';
import 'package:tm_front/screens/recommend_menu_screen.dart';
import 'package:tm_front/screens/recommend_store_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/splash.png', width: 180),
                const SizedBox(width: 16)
              ],
            ),
            const SizedBox(height: 10),
            const HomeMenuButton(name: '프로필'),
            const HomeMenuButton(name: '추천음식'),
            const HomeMenuButton(name: '추천식당'),
            const HomeMenuButton(name: '음식확인'),
          ],
        ),
      ),
    );
  }
}

class HomeMenuButton extends StatelessWidget {
  final String name;
  const HomeMenuButton({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (name == "프로필") {
                return ProfileScreen();
              } else if (name == "추천음식") {
                return const RecommendMenuScreen();
              } else if (name == "추천식당") {
                return RecommendStoreScreen();
              } else {
                return CheckFood();
              }
            },
            // fullscreenDialog: true,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Palette.main,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 250,
          height: 60,
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
