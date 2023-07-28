import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tm_front/screens/check_food_screens/check_food_screen.dart';
import 'package:tm_front/screens/home_screen.dart';
import 'package:tm_front/screens/login_screens/exercise.dart';
import 'package:tm_front/screens/login_screens/basic_inform_screen.dart';
import 'package:tm_front/screens/login_screens/signin_screen.dart';
import 'package:tm_front/screens/login_screens/signup_screen.dart';
import 'package:tm_front/screens/profile_screens/profile_screen.dart';
import 'package:tm_front/screens/reccommend_menu_screens/recommend_menu_screen.dart';
import 'package:tm_front/screens/recommend_store_screens/recommend_store_screen.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'zzf5p9xs3z',
      onAuthFailed: (ex) {
        print('네이버맵 인증오류 : $ex');
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/signin', page: () => const SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/basic_inform', page: () => const BasicInformScreen()),
        GetPage(name: '/activities', page: () => ActivitiesScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(
          name: '/recommend_menu',
          page: () => RecommendMenuScreen(),
        ),
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
// sudo systemctl restart nginx