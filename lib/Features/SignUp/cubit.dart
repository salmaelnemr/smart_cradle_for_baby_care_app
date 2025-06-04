import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cradle_for_baby_care_app/Features/SignUp/states.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../core/caching_utils/caching_utils.dart';
import '../../core/network_utils/network_utils.dart';
import '../../widgets/snack_bar.dart';
import '../BabyInfo/view.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInit());

  final formKey = GlobalKey<FormState>();
  String? fullName, email, password, phoneNumber, confirmPassword;

  Future<void> signUp() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return ;
    }
    emit(SignUpLoading());
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      final response = await NetworkUtils.post(
        'Account/Register',
        data: {
          "fullName": fullName,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
          "confirmPassword": confirmPassword,
          "fcmToken": fcmToken,
        },
      );
      await CachingUtils.cacheUser(response.data);
      print('After caching: ${CachingUtils.isLogged}');
      emit(SignUpInit());
      RouteUtils.pushAndPopAll(
        const BabyInformationView(userId: '',),
      );
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data['message'] ?? '',
        error: true,
      );
    }
  }
}

// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/SignUp/states.dart';
// import '../../Core/route_utils/route_utils.dart';
// import '../../core/caching_utils/caching_utils.dart';
// import '../../core/network_utils/network_utils.dart';
// import '../../widgets/snack_bar.dart';
// import '../BabyInfo/songs.dart';
//
// class SignUpCubit extends Cubit<SignUpStates> {
//   SignUpCubit() : super(SignUpInit());
//
//   final formKey = GlobalKey<FormState>();
//   String? fullName, email, password, phoneNumber, confirmPassword;
//
//   Future<void> signUp() async {
//     formKey.currentState!.save();
//     if (!formKey.currentState!.validate()) {
//       return;
//     }
//     emit(SignUpLoading());
//     try {
//       String? fcmToken = await FirebaseMessaging.instance.getToken();
//       final response = await NetworkUtils.post(
//         'Account/Register',
//         data: {
//           "fullName": fullName,
//           "email": email,
//           "phoneNumber": phoneNumber,
//           "password": password,
//           "confirmPassword": confirmPassword,
//           "fcmToken": fcmToken,
//         },
//       );
//       await CachingUtils.cacheUser(response.data);
//       emit(SignUpInit());
//       RouteUtils.pushAndPopAll(const BabyInformationView());
//     } on DioException catch (e) {
//       showSnackBar(
//         e.response?.data['message'] ?? 'Signup failed',
//         error: true,
//       );
//       emit(SignUpInit());
//     } catch (e) {
//       showSnackBar('An unexpected error occurred: $e', error: true);
//       emit(SignUpInit());
//     }
//   }
// }