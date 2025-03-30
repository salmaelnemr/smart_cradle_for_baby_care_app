// import 'package:shared_preferences/shared_preferences.dart';
//
// class CachingUtils {
//
//   static late SharedPreferences _prefs;
//
//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   static Future<void> cacheUser(Map<String, dynamic> data) async {
//     await _prefs.setString('email', data['data']['email']);
//     await _prefs.setString('name', data['data']['name']);
//     await _prefs.setString('token', data['token']);
//     await _prefs.setString('user_id', data['data']['_id']);
//   }
//
//   static Future<void> deleteUser() async {
//     await _prefs.remove('email');
//     await _prefs.remove('name');
//     await _prefs.remove('token');
//     await _prefs.remove('user_id');
//   }
//
//   static bool get isLogged {
//     return _prefs.containsKey('token');
//   }
//
//   static String get email {
//     return _prefs.getString('email') ?? '';
//   }
//
//   static String get userID {
//     return _prefs.getString('user_id') ?? '';
//   }
//
//   static String get name {
//     return _prefs.getString('name') ?? '';
//   }
//
//   static String get token {
//     return _prefs.getString('token') ?? '';
//   }
// }

// import 'package:shared_preferences/shared_preferences.dart';
//
// class CachingUtils {
//   static SharedPreferences? _prefs; // تغيير late إلى nullable
//
//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   static Future<void> cacheUser(Map<String, dynamic> data) async {
//     if (_prefs == null) return; // تجنب الوصول لـ null
//     await _prefs!.setString('token', data['token']);
//   }
//
//   static Future<void> deleteUser() async {
//     if (_prefs == null) return;
//     await _prefs!.remove('token');
//   }
//
//   static bool get isLogged {
//     return _prefs?.containsKey('token') ?? false;
//   }
//
//   static String get token {
//     return _prefs?.getString('token') ?? '';
//   }
// }


import 'package:shared_preferences/shared_preferences.dart';

class CachingUtils {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> cacheUser(Map<String, dynamic> data) async {
    await _prefs.setString('token', data['token']);
    //await _prefs.setString('user_id', data['user']['id']);
    //await _prefs.setString('email', data['user']['email']);
    //await _prefs.setString('fullName', data['user']['fullName']);
    //await _prefs.setString('phoneNumber', data['user']['phoneNumber']);
  }

  static Future<void> deleteUser() async {
    await _prefs.remove('token');
    // await _prefs.remove('user_id');
    // await _prefs.remove('email');
    // await _prefs.remove('fullName');
    // await _prefs.remove('phoneNumber');
  }

  static bool get isLogged {
    return _prefs.containsKey('token');
  }

  static String get token {
    return _prefs.getString('token') ?? '';
  }

  // static String get userID {
  //   return _prefs.getString('user_id') ?? '';
  // }
  //
  // static String get email {
  //   return _prefs.getString('email') ?? '';
  // }
  //
  // static String get fullName {
  //   return _prefs.getString('fullName') ?? '';
  // }
  //
  // static String get phoneNumber {
  //   return _prefs.getString('phoneNumber') ?? '';
  // }
}