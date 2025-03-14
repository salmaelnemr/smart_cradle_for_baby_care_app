class EndPoint {
  static String baseUrl = "https://1b27-156-197-5-187.ngrok-free.app/api/";
  static String login = "Account/login";
  static String signUp = "Account/Register";
  static String child = "Children";
  static String feeding = "Feedings";
  static String firebasePost = "Firebase/post";
  static String firebaseGet = "Firebase/get";
  static String medicine = "Medicines";
  static String notes = "Notes";
  static String vaccine = "Vaccinations";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String fullName = "fullName";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String message = "message";
  static String id = "id";
  static String phoneNumber = "phoneNumber";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profilePic";
}