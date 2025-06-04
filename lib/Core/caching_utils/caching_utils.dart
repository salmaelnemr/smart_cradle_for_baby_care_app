import 'package:shared_preferences/shared_preferences.dart';

class CachingUtils {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> cacheUser(Map<String, dynamic> data) async {
    await _prefs.setString('token', data['token']);
  }

  static Future<void> deleteUser() async {
    await _prefs.remove('token');
  }

  static bool get isLogged {
    return _prefs.containsKey('token') && _prefs.getString('token') != null && _prefs.getString('token')!.isNotEmpty;
  }

  static String get token {
    return _prefs.getString('token') ?? '';
  }
}