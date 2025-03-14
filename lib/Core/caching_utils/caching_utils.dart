import 'package:shared_preferences/shared_preferences.dart';

class CachingUtils {

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> cacheUser(Map<String, dynamic> data) async {
    await _prefs.setString('email', data['data']['email']);
    await _prefs.setString('name', data['data']['name']);
    await _prefs.setString('token', data['token']);
    await _prefs.setString('user_id', data['data']['_id']);
  }

  static Future<void> deleteUser() async {
    await _prefs.remove('email');
    await _prefs.remove('name');
    await _prefs.remove('token');
    await _prefs.remove('user_id');
  }

  static bool get isLogged {
    return _prefs.containsKey('token');
  }

  static String get email {
    return _prefs.getString('email') ?? '';
  }

  static String get userID {
    return _prefs.getString('user_id') ?? '';
  }

  static String get name {
    return _prefs.getString('name') ?? '';
  }

  static String get token {
    return _prefs.getString('token') ?? '';
  }
}