import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginRequestData extends GetxController {
  Map<String, dynamic> data = {
    'name': '',
    'id': '',
    'email': '',
    'password': '',
    'age': '',
    'tall': '',
    'weight': '',
    'gender': '',
    'like' : [],
    'hate' : [],
    'allergy' : [],
  };
}
