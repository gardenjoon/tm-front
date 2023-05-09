import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tm_front/screens/check_food_screen.dart';
import 'package:tm_front/screens/home_screen.dart';
import 'package:tm_front/screens/login_screens/activation_screen.dart';
import 'package:tm_front/screens/login_screens/basic_inform_screen.dart';
import 'package:tm_front/screens/login_screens/signin_screen.dart';
import 'package:tm_front/screens/login_screens/signup_screen.dart';
import 'package:tm_front/screens/profile_screens/profile_screen.dart';
import 'package:tm_front/screens/recommend_menu_screen.dart';
import 'package:tm_front/screens/recommend_store_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/signin",
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/signin', page: () => const SignInScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/basic_inform', page: () => const BasicInformScreen()),
        GetPage(name: '/activities', page: () => const ActivitiesScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(
            name: '/recommend_menu', page: () => const RecommendMenuScreen()),
        GetPage(name: '/recommend_store', page: () => RecommendStoreScreen()),
        GetPage(name: '/check_food', page: () => CheckFood()),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', ''),
        Locale('en', ''),
      ],
    );
  }
}


// flutter emulators --launch apple_ios_simulator