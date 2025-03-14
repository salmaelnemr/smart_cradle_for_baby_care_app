import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  static const String baseURL = "https://b3db-41-33-88-71.ngrok-free.app/api/Account/Register";  //"http://10.0.2.2:5103/api"
  String? token;

  Future<String> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      FormData userData = FormData.fromMap({
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        //"fcm_token": fcmToken,
      });

      Response response = await Dio().post(
        "$baseURL/Account/Register",
        data: userData,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      await prefs.setString("userToken", response.data["token"]);
      token = prefs.getString('userToken');
      return "Registration Success";
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        print("DioException: ${e.response?.data}");
        return e.response?.data["message"] ?? "Registration failed. Please try again.";
      }
      return "Registration Failed due to an unexpected error.";
    }
  }

  // Future<String> registerUser({
  //   required String fullName,
  //   required String email,
  //   required String phoneNumber,
  //   required String password,
  //   required String confirmPassword,
  // }) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   try {
  //     FormData userData = FormData.fromMap({
  //       "fullName": fullName,
  //       "email": email,
  //       "phoneNumber": phoneNumber,
  //       "password": password,
  //       "confirmPassword": confirmPassword,
  //     });
  //     Response response = await Dio().post(
  //       "$baseURL/Account/Register",
  //       data: userData,
  //         options: Options(
  //           headers: {
  //             'Content-Type': 'application/json; charset=utf-8',
  //             'Accept': 'application/json',
  //           },
  //         )
  //
  //     );
  //     await prefs.setString("userToken", response.data["token"]);
  //
  //     token = prefs.getString('userToken');
  //     return "Registration Success";
  //   } catch (e) {
  //     print(e.toString());
  //     if (e is DioException) {
  //       print("DioException: ${e.response?.data}");
  //       return e.response?.data["message"] ?? "Registration failed. Please try again.";
  //     }
  //     return "Registration Failed due to an unexpected error.";
  //   }
  // }

  Future<String> userLogin({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      FormData userData = FormData.fromMap({
        "email": email,
        "password": password,
      });
      Response response = await Dio().post(
        "$baseURL/Account/login",
        data: userData,
      );
      await prefs.setString("userToken", response.data["token"]);

      token = prefs.getString('userToken');
      return "Login Success";
    } catch (e) {
      if (e is DioException) {
        return e.response?.data["message"];
      }
      return "Login Failed";
    }
  }
}

// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ApiProvider {
//   static const String baseURL = "https://1b27-156-197-5-187.ngrok-free.app/api/";
//   String? token;
//   final Dio dio = Dio();
//
//
//   Future<String?> getFCMToken() async {
//     try {
//       String? fcmToken = await FirebaseMessaging.instance.getToken();
//       print("FCM Token: $fcmToken");
//       return fcmToken;
//     } catch (e) {
//       print("Error getting FCM Token: $e");
//       return null;
//     }
//   }
//
//   Future<String> registerUser({
//     required String fullName,
//     required String email,
//     required String phoneNumber,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     try {
//       String? fcmToken = await getFCMToken();
//
//       Map<String, dynamic> userData = {
//         "fullName": fullName,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "password": password,
//         "confirmPassword": confirmPassword,
//         "fcmToken": fcmToken,
//       };
//
//       Response response = await dio.post(
//         "$baseURL/Account/Register",
//         data: userData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       String? userToken = response.data["token"];
//       if (userToken != null) {
//         await prefs.setString("userToken", userToken);
//       }
//
//       return "Registration Success";
//     } catch (e) {
//       print("Error: $e");
//       if (e is DioException) {
//         print("DioException: ${e.response?.data}");
//         return e.response?.data?["message"] ?? "Registration failed. Please try again.";
//       }
//       return "Registration Failed due to an unexpected error.";
//     }
//   }
//
//   Future<String> userLogin({
//     required String email,
//     required String password,
//   }) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     try {
//       String? fcmToken = await getFCMToken();
//
//       Map<String, dynamic> userData = {
//         "email": email,
//         "password": password,
//         "fcmToken": fcmToken,
//       };
//
//       Response response = await dio.post(
//         "$baseURL/Account/Login",
//         data: userData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       String? userToken = response.data["token"];
//       if (userToken != null) {
//         await prefs.setString("userToken", userToken);
//       }
//
//       return "Login Success";
//     } catch (e) {
//       print("Error: $e");
//       if (e is DioException) {
//         return e.response?.data?["message"] ?? "Login failed. Please try again.";
//       }
//       return "Login Failed due to an unexpected error.";
//     }
//   }
// }


