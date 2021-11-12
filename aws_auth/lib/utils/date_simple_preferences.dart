import 'package:shared_preferences/shared_preferences.dart';

class DateSimplePreferences {
  static SharedPreferences? _preferences;

  //static const _keyEnddate = 'enddate';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setEndDate(String endDate) async {
    return await _preferences?.setString('dateEndPref', endDate);
  }

  static String? getEnddate() => _preferences?.getString('dateEndPref');
}
