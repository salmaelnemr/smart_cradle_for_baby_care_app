// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../../Widgets/snack_bar.dart';
// import '../caching_utils/caching_utils.dart';
//
// class ApiProvider {
//   static const String baseURL = "http://babycradleapp.runasp.net/api";
//   String? token;
//
//   Future<String> registerUser({
//     required String fullName,
//     required String email,
//     required String phoneNumber,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     try {
//       String? fcmToken = await FirebaseMessaging.instance.getToken();
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
//       Response response = await Dio().post(
//         "$baseURL/Account/Register",
//         data: userData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json; charset=utf-8',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         //String userId = response.data["userId"];
//         //return userId;
//         //await CachingUtils.cacheUser(response.data);
//         return "Registration Success";
//       } else {
//         return "Registration failed. Please try again.";
//       }
//     } on DioException catch (e){
//       showSnackBar(
//         e.response?.data["message"] ?? '',
//         error: true,
//       );
//       //print(e.response?.statusCode);
//       //print(e.response?.data["message"]);
//       //return e.response?.data["message"];
//     } return "Registration Failed due to an unexpected error.";
//   }
//
//   Future<String> addChild({
//     required String name,
//     required String dateOfbirth,
//   }) async {
//     try {
//       String? userId = await ;
//
//       Map<String, dynamic> childData = {
//         "userId": userId,
//         "name": name,
//         "dateOfbirth": dateOfbirth,
//       };
//
//       Response response = await Dio().post(
//         "$baseURL/Children",
//         data: childData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json; charset=utf-8',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         //await CachingUtils.cacheUser(response.data);
//         return "Child added successfully";
//       } else {
//         return "Added child failed";
//       }
//     } on DioException catch (e){
//       showSnackBar(
//         e.response?.data["message"] ?? '',
//         error: true,
//       );
//       //print(e.response?.statusCode);
//       //print(e.response?.data["message"]);
//       //return e.response?.data["message"];
//     } return "Add child Failed due to an unexpected error.";
//   }
//   //     await CachingUtils.cacheUser(response.data);
//   //
//   //     return "Registration Success";
//   //   } catch (e) {
//   //     print(e.toString());
//   //     if (e is DioException) {
//   //       print("DioException: ${e.response?.data}");
//   //       return e.response?.data["message"] ?? "Registration failed. Please try again.";
//   //     }
//   //     return "Registration Failed due to an unexpected error.";
//   //   }
//   // }
//
//   Future<String> userLogin({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       Map<String, dynamic> userData = {
//         "email": email,
//         "password": password,
//       };
//
//       Response response = await Dio().post(
//         "$baseURL/Account/login",
//         data: userData,
//       );
//
//       // await CachingUtils.cacheUser(response.data);
//       //
//       // return "Login Success";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         //await CachingUtils.cacheUser(response.data);
//         return "Login success";
//       } else {
//         return "Login failed. Please try again.";
//       }
//     } on DioException catch (e){
//       showSnackBar(
//         e.response?.data["message"] ?? '',
//         error: true,
//       );
//       //print(e.response?.statusCode);
//       //print(e.response?.data["message"]);
//       return e.response?.data["message"];
//     }
//     // catch (e) {
//     //   if (e is DioException) {
//     //     return e.response?.data["message"];
//     //   }
//     //   return "Login Failed due to an unexpected error.";
//     // }
//   }
// }
//
//

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/snack_bar.dart';
import '../models/user_model.dart';

class ApiProvider {
  static const String baseURL = "http://babycradleapp.runasp.net/api";
  String? token;
  UserModel? userModel;

  Future<String> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      Map<String, dynamic> userData = {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "fcmToken": fcmToken,
      };

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.data.toString();
        String userId =
            responseString.split(':')[1]; // Extract the UUID after "UserId:"
        //await CachingUtils.cacheUser({'userId': userId}); // Cache if needed
        return userId;
      } else {
        return "Registration failed. Please try again.";
      }
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? '',
        error: true,
      );
      return "Registration Failed due to an unexpected error.";
    }
  }

  Future<String> addChild({
    required String userId,
    required String name,
    required String dateOfbirth,
  }) async {
    try {
      Map<String, dynamic> childData = {
        "userId": userId,
        "name": name,
        "dateOfbirth": dateOfbirth,
      };

      Response response = await Dio().post(
        "$baseURL/Children",
        data: childData,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Child added successfully";
      } else {
        return "Added child failed";
      }
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? '',
        error: true,
      );
      print(e.response?.data["message"]);
      return "Add child Failed due to an unexpected error.";
    }
  }

  Future<String> cradlePasscode({
    required String userId,
    required String passCode,
  }) async {
    try {
      Map<String, dynamic> passcodeData = {
        "userId": userId,
        "passCode": passCode,
      };

      Response response = await Dio().post(
        "$baseURL/Account/PassCode",
        data: passcodeData,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Passcode submitted successfully";
      } else {
        return "Passcode submission failed";
      }
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? '',
        error: true,
      );
      return "Passcode submission failed due to an unexpected error.";
    }
  }
  Future<String> userLogin({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Map<String, dynamic> userData = {
        "email": email,
        "password": password,
      };

      Response response = await Dio().post(
        "$baseURL/Account/login",
        data: userData,
      );
      await prefs.remove('userToken');
      String tokenFromResponse = response.data["token"];
      await prefs.setString("userToken", tokenFromResponse);
      print("Token stored: $tokenFromResponse");

      token = tokenFromResponse;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Login success";
      } else {
        return "Login failed. Please try again.";
      }
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? '',
        error: true,
      );
      return e.response?.data["message"] ??
          "Login Failed due to an unexpected error.";
    }
  }

  Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      print("Token: $token");

      if (token == null) {
        print("No token found. User might not be logged in.");
        return null;
      }

      Response response = await Dio().get(
        "$baseURL/Account/UserInfo",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print("Response Data: ${response.data}");
      userModel = UserModel.fromJson(response.data);
      return userModel;
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch user info.",
        error: true,
      );
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }

  Future<bool> updateProfilePicture(File imageFile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        throw Exception('No authentication token found');
      }

      FormData formData = FormData.fromMap({
        'ProfilePicture': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_picture.jpg',
        ),
      });

      Response response = await Dio().put(
        "$baseURL/Account/update-profilePicture",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        showSnackBar(
          'Failed to update profile picture',
          error: true,
        );
        return false;
      }
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? 'Error updating profile picture',
        error: true,
      );
      return false;
    }
  }

  Future<bool> updateProfile({
    required String fullName,
    required String email,
    String? phoneNumber,
    String? oldPassword,
    String? newPassword,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        throw Exception('No authentication token found');
      }

      Map<String, dynamic> data = {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber ?? "",
        "oldPassword": oldPassword ?? "",
        "newPassword": newPassword ?? "",
      };

      Response response = await Dio().put(
        "$baseURL/Account/update-profile",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        showSnackBar(
          'Failed to update profile',
          error: true,
        );
        return false;
      }
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? 'Error updating profile',
        error: true,
      );
      return false;
    }
  }

  Future<bool> updateChild({
    required String name,
    required String dateOfBirth,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        throw Exception('No authentication token found');
      }

      Map<String, dynamic> data = {
        "name": name,
        "dateOfbirth": dateOfBirth,
      };

      Response response = await Dio().put(
        "$baseURL/Children",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        showSnackBar(
          'Failed to update child profile',
          error: true,
        );
        return false;
      }
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? 'Error updating child profile',
        error: true,
      );
      return false;
    }
  }
}

// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// import '../../Widgets/snack_bar.dart';
// import '../caching_utils/caching_utils.dart';
//
// class ApiProvider {
//   static const String baseURL = "http://babycradleapp.runasp.net/api";
//   String? token;
//
//   Future<String> registerUser({
//     required String fullName,
//     required String email,
//     required String phoneNumber,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     try {
//       String? fcmToken = await FirebaseMessaging.instance.getToken();
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
//       Response response = await Dio().post(
//         "$baseURL/Account/Register",
//         data: userData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json; charset=utf-8',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         //String userId = response.data["UserId"];
//         String responseString = response.data.toString();
//         String userId = responseString.split(':')[1];// Extract userId from response
//         await CachingUtils.cacheUser({'UserId': userId}); // Cache the response if needed
//         return userId; // Return userId instead of message
//       } else {
//         return "Registration failed. Please try again.";
//       }
//     } on DioException catch (e) {
//       showSnackBar(
//         //e.response?.data,
//         e.response?.data["message"] ?? '',
//         error: true,
//       );
//       return "Registration Failed due to an unexpected error.";
//     }
//   }
//
//   Future<String> addChild({
//     required String userId, // Add userId as parameter
//     required String name,
//     required String dateOfbirth,
//   }) async {
//     try {
//       Map<String, dynamic> childData = {
//         "userId": userId,
//         "name": name,
//         "dateOfbirth": dateOfbirth,
//       };
//
//       Response response = await Dio().post(
//         "$baseURL/Children",
//         data: childData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json; charset=utf-8',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return "Child added successfully";
//       } else {
//         return "Added child failed";
//       }
//     } on DioException catch (e) {
//       showSnackBar(
//         e.response?.data["message"] ?? '',
//         error: true,
//       );
//       return "Add child Failed due to an unexpected error.";
//     }
//   }
// }
