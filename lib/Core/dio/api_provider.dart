import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:smart_cradle_for_baby_care_app/Core/models/sensor_status_model.dart';
import '../../Widgets/snack_bar.dart';
import '../caching_utils/caching_utils.dart';
import '../errors/api_exceptions.dart';
import '../models/baby_temp_model.dart';
import '../models/feeding_model.dart';
import '../models/medicine_model.dart';
import '../models/note_model.dart';
import '../models/user_model.dart';
import '../models/vaccine_model.dart';
import 'api_client.dart';

class ApiProvider {
  final ApiClient _client = ApiClient();

  Future<String> _handleError(DioException e, String defaultMessage) async {
    final errorMessage = e.response?.data is Map
        ? e.response?.data["message"] ?? defaultMessage
        : defaultMessage;
    showSnackBar(errorMessage, error: true);
    return errorMessage;
  }

  Future<String> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final userData = {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "fcmToken": fcmToken,
      };

      final response = await _client.post("/Account/Register", data: userData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseString = response.data.toString();
        final userId = responseString.split(':')[1];
        return userId;
      }
      return "Registration failed. Please try again.";
    } on DioException catch (e) {
      return _handleError(e, "Registration Failed due to an unexpected error.");
    }
  }

  Future<String> addChild({
    required String userId,
    required String name,
    required String dateOfbirth,
  }) async {
    try {
      final childData = {
        "userId": userId,
        "name": name,
        "dateOfbirth": dateOfbirth,
      };

      final response = await _client.post("/Children", data: childData);
      return response.statusCode == 200 || response.statusCode == 201
          ? "Child added successfully"
          : "Added child failed";
    } on DioException catch (e) {
      return _handleError(e, "Add child Failed due to an unexpected error.");
    }
  }

  Future<String> cradlePasscode({
    required String userId,
    required String passCode,
  }) async {
    try {
      final passcodeData = {
        "userId": userId,
        "passCode": passCode,
      };

      final response = await _client.post("/Account/PassCode", data: passcodeData);
      return response.statusCode == 200 || response.statusCode == 201
          ? "Passcode submitted successfully"
          : "Passcode submission failed";
    } on DioException catch (e) {
      return _handleError(e, "Passcode submission failed due to an unexpected error.");
    }
  }

  Future<String> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final userData = {
        "email": email,
        "password": password,
      };

      final response = await _client.post("/Account/login", data: userData);
      final token = response.data["token"];
      await CachingUtils.cacheUser({'token': token});

      return response.statusCode == 200 || response.statusCode == 201
          ? "Login success"
          : "Login failed. Please try again.";
    } on DioException catch (e) {
      return _handleError(e, "Login Failed due to an unexpected error.");
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return null;

      final response = await _client.get("/Account/UserInfo", token: token);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch user info.",
        error: true,
      );
      return null;
    }
  }

  Future<bool> updateProfilePicture(File imageFile) async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) throw ApiException('No authentication token found');

      final formData = FormData.fromMap({
        'ProfilePicture': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_picture.jpg',
        ),
      });

      final response = await _client.put(
        "/Account/update-profilePicture",
        data: formData,
        token: token,
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? 'Error updating profile picture',
        error: true,
      );
      return false;
    } on ApiException catch (e) {
      showSnackBar(e.message, error: true);
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
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) throw ApiException('No authentication token found');

      final data = {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber ?? "",
        "oldPassword": oldPassword ?? "",
        "newPassword": newPassword ?? "",
      };

      final response = await _client.put("/Account/update-profile", data: data, token: token);
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? 'Error updating profile',
        error: true,
      );
      return false;
    } on ApiException catch (e) {
      showSnackBar(e.message, error: true);
      return false;
    }
  }

  Future<bool> updateChild({
    required String name,
    required String dateOfBirth,
  }) async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) throw ApiException('No authentication token found');

      final data = {
        "name": name,
        "dateOfbirth": dateOfBirth,
      };

      final response = await _client.put("/Children", data: data, token: token);
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? 'Error updating child profile',
        error: true,
      );
      return false;
    } on ApiException catch (e) {
      showSnackBar(e.message, error: true);
      return false;
    }
  }

  Future<BabyTempModel?> getBabyTemp() async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return null;

      final response = await _client.get("/BabyTemp", token: token);
      return BabyTempModel.fromJson(response.data);
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch baby temperature.",
        error: true,
      );
      return null;
    }
  }

  Future<SensorDataStatusModel?> getSensorStatus() async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return null;

      final response = await _client.get("/Status/data-status", token: token);
      return SensorDataStatusModel.fromJson(response.data);
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch sensor data status.",
        error: true,
      );
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
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final data = {
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
        "remindMe": remindMe,
      };

      final response = await _client.post("/Feedings", data: data, token: token);
      return response.statusCode == 200 || response.statusCode == 201
          ? "Feeding added successfully!"
          : "Failed to add feeding.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to add feeding.");
    }
  }

  Future<List<FeedingModel>?> getFeedingNote() async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return null;

      final response = await _client.get("/Feedings", token: token);
      return feedingModelFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch Feeding data.",
        error: true,
      );
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
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final data = {
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
      };

      final response = await _client.put("/Feedings/EditFeeding/$id", data: data, token: token);
      return response.statusCode == 200
          ? "Feeding updated successfully!"
          : "Failed to update feeding.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to update feeding.");
    }
  }

  Future<String> deleteFeeding(int id) async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final response = await _client.delete("/Feedings/DeleteFeeding/$id", token: token);
      return response.statusCode == 200
          ? "Feeding deleted successfully!"
          : "Failed to delete feeding.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to delete feeding.");
    }
  }

  Future<List<FeedingModel>> getFeedingsByDate(DateTime date) async {
    final allFeedings = await getFeedingNote();
    if (allFeedings == null) return [];

    final selectedDateStr = DateFormat('yyyy-MM-dd').format(date);
    return allFeedings.where((feeding) {
      if (feeding.time == null) return false;
      return DateFormat('yyyy-MM-dd').format(feeding.time!) == selectedDateStr;
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
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final data = {
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
        "remindMe": remindMe,
        "medicineName": medicineName,
      };

      final response = await _client.post("/Medicines", data: data, token: token);
      return response.statusCode == 200 || response.statusCode == 201
          ? "Medicine added successfully!"
          : "Failed to add medicine.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to add medicine.");
    }
  }

  Future<List<MedicineModel>?> getMedicineNote() async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return null;

      final response = await _client.get("/Medicines", token: token);
      return medicineModelFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch Medicine data.",
        error: true,
      );
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
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final data = {
        "medicineName": medicineName,
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
      };

      final response = await _client.put("/Medicines/EditMedicine/$id", data: data, token: token);
      return response.statusCode == 200
          ? "Medicine updated successfully!"
          : "Failed to update medicine.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to update medicine.");
    }
  }

  Future<String> deleteMedicine(int id) async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final response = await _client.delete("/Medicines/DeleteMedicine/$id", token: token);
      return response.statusCode == 200
          ? "Medicine deleted successfully!"
          : "Failed to delete medicine.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to delete medicine.");
    }
  }

  Future<List<MedicineModel>> getMedicinesByDate(DateTime date) async {
    final medicines = await getMedicineNote();
    if (medicines == null) return [];

    final selectedDateStr = DateFormat('yyyy-MM-dd').format(date);
    return medicines.where((medicine) {
      if (medicine.notificationTime == null) return false;
      return DateFormat('yyyy-MM-dd').format(medicine.notificationTime!) == selectedDateStr;
    }).toList();
  }

  Future<String> addNote({
    required String title,
    required String content,
    required String notificationDate,
    required String notificationTime,
    required bool isPM,
  }) async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final data = {
        "title": title,
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
      };

      final response = await _client.post("/Notes", data: data, token: token);
      return response.statusCode == 200 || response.statusCode == 201
          ? "Note added successfully!"
          : "Failed to add note.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to add note.");
    }
  }

  Future<List<NoteModel>?> getStickyNote() async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return null;

      final response = await _client.get("/Notes", token: token);
      return noteModelFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch Note data.",
        error: true,
      );
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
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final data = {
        "title": title,
        "content": content,
        "notificationDate": notificationDate,
        "notificationTime": notificationTime,
        "isPM": isPM,
      };

      final response = await _client.put("/Notes/EditNote/$id", data: data, token: token);
      return response.statusCode == 200
          ? "Note updated successfully!"
          : "Failed to update note.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to update note.");
    }
  }

  Future<String> deleteNote(int id) async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return "No token found. Please log in again.";

      final response = await _client.delete("/Notes/DeleteNote/$id", token: token);
      return response.statusCode == 200
          ? "Note deleted successfully!"
          : "Failed to delete note.";
    } on DioException catch (e) {
      return _handleError(e, "Failed to delete note.");
    }
  }

  Future<List<NoteModel>> getStickyNotesByDate(DateTime date) async {
    final allNotes = await getStickyNote();
    if (allNotes == null) return [];

    final selectedDateStr = DateFormat('yyyy-MM-dd').format(date);
    return allNotes.where((note) {
      if (note.time == null) return false;
      return DateFormat('yyyy-MM-dd').format(note.time!) == selectedDateStr;
    }).toList();
  }

  Future<List<VaccineModel>?> getVaccinesNote() async {
    try {
      final token = CachingUtils.token;
      if (token.isEmpty) return null;

      final response = await _client.get("/Vaccinations", token: token);
      return vaccineModelFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data["message"] ?? "Failed to fetch vaccine data.",
        error: true,
      );
      return null;
    }
  }
}