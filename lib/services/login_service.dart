import 'package:get/get.dart';
import 'package:tm_front/models/login_model.dart';

class LoginService {
  static const String baseUrl = 'http://data.pknu.ac.kr:7443/api/user';

  static signUp() async {
    final loginData = Get.put(LoginRequestData());

    print(loginData.data);
    // final url = Uri.parse('$baseUrl/profile/$id');
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   final profile = jsonDecode(response.body);
    //   return ProfileModel.fromJson(profile["data"]);
    // } else {
    //   throw Error();
    // }
  }
}
