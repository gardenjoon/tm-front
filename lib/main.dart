import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/screens/home_screen.dart';
import 'package:tm_front/screens/login_screens/activation_screen.dart';
import 'package:tm_front/screens/login_screens/basic_inform_screen.dart';
import 'package:tm_front/screens/login_screens/signin_screen.dart';
import 'package:tm_front/screens/login_screens/signup_screen.dart';
import 'package:tm_front/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/home",
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/signin', page: () => const SignInScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/basic_inform', page: () => const BasicInformScreen()),
        GetPage(name: '/activities', page: () => const ActivitiesScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        // GetPage(
        //     name: '/choose_food',
        //     fullscreenDialog: true,
        //     page: () => const ChooseFoodScreen(),
        //     transition: Transition.downToUp,
        //     transitionDuration: const Duration(milliseconds: 300)),
      ],
    );
  }
}
