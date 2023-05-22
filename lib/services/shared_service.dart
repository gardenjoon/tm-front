import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class SharedService {
  static void saveData(String name, List<dynamic> data) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonData = jsonEncode(data);
    await prefs.setString(name, jsonData);
  }

  static Future<List<dynamic>> loadData(String name) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonData = prefs.getString(name);
    if (jsonData != null) {
      return jsonDecode(jsonData);
    } else {
      return [];
    }
  }

  static void clearData(String name) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(name);
  }

  static void clearData24HPassed(String name) {
    Timer.periodic(const Duration(hours: 24), (timer) {
      clearData(name);
    });
  }

  static void executeFunction() {
    clearData24HPassed('아침');
    clearData24HPassed('점심');
    clearData24HPassed('저녁');
  }

  static void scheduleDailyTask() {
    Timer.periodic(const Duration(hours: 24), (timer) {
      var scheduledDate = _nextInstanceOfFourAM();
      if (DateTime.now().isBefore(scheduledDate)) {
        Timer(
            tz.TZDateTime.from(scheduledDate, tz.local)
                .difference(DateTime.now()),
            () => executeFunction());
      } else {
        Timer(Duration.zero, () => executeFunction());
      }
    });
  }

  static DateTime _nextInstanceOfFourAM() {
    var now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, 18);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
