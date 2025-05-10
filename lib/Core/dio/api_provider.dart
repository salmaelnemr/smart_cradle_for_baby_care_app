import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/snack_bar.dart';
import '../models/baby_temp_model.dart';
import '../models/feeding_model.dart';
import '../models/medicine_model.dart';
import '../models/note_model.dart';
import '../models/user_model.dart';
import '../models/vaccine_model.dart';

class ApiProvider {
  static const String baseURL = "http://babycradleapp.runasp.net/api";
  String? token;
  UserModel? userModel;
  BabyTempModel? babyTempModel;
  VaccineModel? vaccineModel;
  FeedingModel? feedingModel;
  MedicineModel? medicineModel;
  NoteModel? noteModel;
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
            responseString.split(':')[1];
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
      //print(e.response?.data["message"]);
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
      //print("Token stored: $tokenFromResponse");

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
      //print("Token: $token");

      if (token == null) {
        //print("No token found. User might not be logged in.");
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
      //print("Response Data: ${response.data}");
      userModel = UserModel.fromJson(response.data);
      return userModel;
    } on DioException catch (e) {
      //print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch user info.",
        error: true,
      );
      return null;
    } catch (e) {
      //print("Unexpected error: $e");
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

  Future<BabyTempModel?> getBabyTemp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      //print("Token: $token");

      if (token == null) {
        //print("No token found. User might not be logged in.");
        return null;
      }

      Response response = await Dio().get(
        "$baseURL/BabyTemp",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      //print("Response Data: ${response.data}");
      babyTempModel = BabyTempModel.fromJson(response.data);
      return babyTempModel;
    } on DioException catch (e) {
      //print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch baby temperature.",
        error: true,
      );
      return null;
    } catch (e) {
      //print("Unexpected error: $e");
      return null;
    }
  }
  Future<String> addFeeding({
    required String content,
    required String notificationDate,
    required String notificationTime,
    required bool isPM,
    required int remindMe,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Map<String, dynamic> userData = {
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
        "remindMe": remindMe,
      };

      Response response = await Dio().post(
        "$baseURL/Feedings",
        data: userData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      print("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Feeding added successfully!";
      } else {
        return "Failed to add feeding.";
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to add feeding."
          : "Failed to add feeding.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("Unexpected error: $e");
      return "Something went wrong.";
    }
  }

  Future<List<FeedingModel>?> getFeedingNote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      token = prefs.getString('userToken');
      print("Token: $token");

      if (token == null) {
        print("No token found. User might not be logged in.");
        return null;
      }

      Response response = await Dio().get(
        "$baseURL/Feedings",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print("Response Data: ${response.data}");

      List<FeedingModel> feedingList =
      feedingModelFromJson(jsonEncode(response.data));
      return feedingList;
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to fetch Feeding data."
          : "Failed to fetch Feeding data.";

      showSnackBar(errorMessage, error: true);
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }

  Future<String> putFeeding({
    required int id,
    required String content,
    required String notificationDate,
    required String notificationTime,
    required bool isPM,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Map<String, dynamic> userData = {
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM
      };

      Response response = await Dio().put(
        "$baseURL/Feedings/EditFeeding/$id",
        data: userData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      print("PUT Response: ${response.data}");

      if (response.statusCode == 200) {
        return "Feeding updated successfully!";
      } else {
        return "Failed to update feeding.";
      }
    } on DioException catch (e) {
      print(
          "PUT DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to update feeding."
          : "Failed to update feeding.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("PUT Unexpected error: $e");
      return "Something went wrong.";
    }
  }

  Future<String> deleteFeeding(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Response response = await Dio().delete(
        "$baseURL/Feedings/DeleteFeeding/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("DELETE Response: ${response.data}");

      if (response.statusCode == 200) {
        return "Feeding deleted successfully!";
      } else {
        return "Failed to delete feeding.";
      }
    } on DioException catch (e) {
      print(
          "DELETE DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to delete feeding."
          : "Failed to delete feeding.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("DELETE Unexpected error: $e");
      return "Something went wrong.";
    }
  }

  Future<List<FeedingModel>> getFeedingsByDate(DateTime date) async {
    final allFeedings = await getFeedingNote();
    if (allFeedings == null) return [];

    String selectedDateStr = DateFormat('yyyy-MM-dd').format(date);

    return allFeedings.where((feeding) {
      if (feeding.time == null) return false;
      String feedingDateStr = DateFormat('yyyy-MM-dd').format(feeding.time!);
      return feedingDateStr == selectedDateStr;
    }).toList();
  }

  Future<String> addMedicine({
    required String content,
    required String notificationDate,
    required String notificationTime,
    required bool isPM,
    required int remindMe,
    required String medicineName,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Map<String, dynamic> requestBody = {
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
        "remindMe": remindMe,
        "medicineName": medicineName,
      };

      Response response = await Dio().post(
        "$baseURL/Medicines",
        data: requestBody,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      print("POST Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Medicine added successfully!";
      } else {
        return "Failed to add medicine.";
      }
    } on DioException catch (e) {
      print("POST DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to add medicine."
          : "Failed to add medicine.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("POST Unexpected error: $e");
      return "Something went wrong.";
    }
  }



  Future<List<MedicineModel>?> getMedicineNote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      token = prefs.getString('userToken');
      print("Token: $token");

      if (token == null) {
        print("No token found. User might not be logged in.");
        return null;
      }

      Response response = await Dio().get(
        "$baseURL/Medicines",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print("Response Data: ${response.data}");

      List<MedicineModel> medicineList =
      medicineModelFromJson(jsonEncode(response.data));
      return medicineList;
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to fetch Medicine data."
          : "Failed to fetch Medicine data.";

      showSnackBar(errorMessage, error: true);
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }

  Future<String> putMedicine({
    required int id,
    required String medicineName,
    required String content,
    required String notificationDate,
    required String notificationTime,
    required bool isPM,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      final Map<String, dynamic> requestBody = {
        "medicineName": medicineName,
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
      };

      final response = await Dio().put(
        "$baseURL/Medicines/EditMedicine/$id",
        data: requestBody,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      print("PUT Response: ${response.data}");

      if (response.statusCode == 200) {
        return "Medicine updated successfully!";
      } else {
        return "Failed to update medicine.";
      }
    } on DioException catch (e) {
      print("PUT DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to update medicine."
          : "Failed to update medicine.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("PUT Unexpected error: $e");
      return "Something went wrong.";
    }
  }

  Future<String> deleteMedicine(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Response response = await Dio().delete(
        "$baseURL/Medicines/DeleteMedicine/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("DELETE Response: ${response.data}");

      if (response.statusCode == 200) {
        return "Medicine deleted successfully!";
      } else {
        return "Failed to delete medicine.";
      }
    } on DioException catch (e) {
      print(
          "DELETE DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to delete medicine."
          : "Failed to delete medicine.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("DELETE Unexpected error: $e");
      return "Something went wrong.";
    }
  }

  Future<List<MedicineModel>> getMedicinesByDate(DateTime date) async {
    final medicines = await getMedicineNote();
    if (medicines == null) return [];

    String selectedDateStr = DateFormat('yyyy-MM-dd').format(date);

    return medicines.where((medicine) {
      if (medicine.notificationTime == null) return false;
      String medicineDateStr = DateFormat('yyyy-MM-dd').format(medicine.notificationTime!);
      return medicineDateStr == selectedDateStr;
    }).toList();
  }


  Future<String> addNote({
    required String title,
    required String content,
    required String notificationDate,
    required String notificationTime,
    required bool isPM,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Map<String, dynamic> userData = {
        "title": title,
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
      };

      Response response = await Dio().post(
        "$baseURL/Notes",
        data: userData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      print("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Note added successfully!";
      } else {
        return "Failed to add note.";
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to add Note."
          : "Failed to add Note.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("Unexpected error: $e");
      return "Something went wrong.";
    }
  }


  Future<List<NoteModel>?> getStickyNote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      token = prefs.getString('userToken');
      print("Token: $token");

      if (token == null) {
        print("No token found. User might not be logged in.");
        return null;
      }

      Response response = await Dio().get(
        "$baseURL/Notes",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print("Response Data: ${response.data}");

      List<NoteModel> noteList = noteModelFromJson(jsonEncode(response.data));
      return noteList;
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to fetch Note data."
          : "Failed to fetch Note data.";

      showSnackBar(errorMessage, error: true);
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }

  Future<String> putNote({
    required int id,
    required String title,
    required String content,
    required String notificationDate,
    required String notificationTime,
    required bool isPM,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Map<String, dynamic> userData = {

          "title": title,
          "content": content,
          "notificationDate": notificationDate,
          "notificationTime": notificationTime,
          "isPM": isPM,
      };

      Response response = await Dio().put(
        "$baseURL/Notes/EditNote/$id",
        data: userData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
        ),
      );

      print("PUT Response: ${response.data}");

      if (response.statusCode == 200) {
        return "Note updated successfully!";
      } else {
        return "Failed to update Note.";
      }
    } on DioException catch (e) {
      print("PUT DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to update Note."
          : "Failed to update Note.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("PUT Unexpected error: $e");
      return "Something went wrong.";
    }
  }


  Future<String> deleteNote(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? token = prefs.getString('userToken');
      if (token == null) {
        return "No token found. Please log in again.";
      }

      Response response = await Dio().delete(
        "$baseURL/Notes/DeleteNote/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("DELETE Response: ${response.data}");

      if (response.statusCode == 200) {
        return "Note deleted successfully!";
      } else {
        return "Failed to delete Note.";
      }
    } on DioException catch (e) {
      print(
          "DELETE DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to delete Note."
          : "Failed to delete Note.";
      showSnackBar(errorMessage, error: true);
      return errorMessage;
    } catch (e) {
      print("DELETE Unexpected error: $e");
      return "Something went wrong.";
    }
  }

  Future<List<NoteModel>> getStickyNotesByDate(DateTime date) async {
    final allNotes = await getStickyNote();
    if (allNotes == null) return [];

    String selectedDateStr = DateFormat('yyyy-MM-dd').format(date);

    return allNotes.where((note) {
      if (note.time == null) return false;
      String noteDateStr = DateFormat('yyyy-MM-dd').format(note.time!);
      return noteDateStr == selectedDateStr;
    }).toList();
  }

  Future<List<VaccineModel>?> getVaccinesNote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      token = prefs.getString('userToken');
      print("Token: $token");

      if (token == null) {
        print("No token found. User might not be logged in.");
        return null;
      }

      Response response = await Dio().get(
        "$baseURL/Vaccinations",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print("Response Data: ${response.data}");

      List<VaccineModel> vaccineList =
      vaccineModelFromJson(jsonEncode(response.data));
      return vaccineList;
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      final errorMessage = e.response?.data is Map
          ? e.response?.data["message"] ?? "Failed to fetch vaccine data."
          : "Failed to fetch vaccine data.";

      showSnackBar(errorMessage, error: true);
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }
}

