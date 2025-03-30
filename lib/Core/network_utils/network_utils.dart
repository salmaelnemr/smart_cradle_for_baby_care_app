// import 'package:dio/dio.dart';
// import '../caching_utils/caching_utils.dart';
//
// class NetworkUtils {
//   static const String _baseURL = 'http://babycradleapp.runasp.net/api/';
//
//   //static late Dio _dio;
//   static late Dio _dio;
//
//   static Future<void> init() async {
//     _dio = Dio();
//     _dio.options.baseUrl = _baseURL;
//     _dio.options.validateStatus = (v) => v! < 500;
//   }
//
//   static Future<Response<dynamic>> post(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? headers,
//   }) async {
//     // if (headers == null && CachingUtils.isLogged) {
//     //   headers = {'Authorization': 'Bearer ${CachingUtils.token}'};
//     // }
//     return _dio.post(
//       path,
//       data: data,
//       options: Options(
//         headers: headers,
//       ),
//     );
//   }
//
//   static Future<Response<dynamic>> patch(
//       String path, {
//         Object? data,
//         Map<String, dynamic>? headers,
//       }) async {
//     if (headers == null && CachingUtils.isLogged) {
//       headers = {"Authorization": "Bearer ${CachingUtils.token}"};
//     }
//     return _dio.patch(
//       path,
//       data: data,
//       options: Options(
//         headers: headers,
//       ),
//     );
//   }
//
//   static Future<Response<dynamic>> get(
//     String path, {
//     Map<String, dynamic>? headers,
//   }) async {
//     if (headers == null && CachingUtils.isLogged) {
//       headers = {'Authorization': 'Bearer ${CachingUtils.token}'};
//     }
//     return _dio.get(
//       path,
//       options: Options(
//         headers: headers,
//       ),
//     );
//   }
//
//   static Future<Response<dynamic>> delete(
//       String path, {
//         Map<String, dynamic>? headers,
//       }) async {
//     if (headers == null && CachingUtils.isLogged) {
//       headers = {"Authorization": "Bearer ${CachingUtils.token}"};
//     }
//     return _dio.delete(
//       path,
//       options: Options(
//         headers: headers,
//       ),
//     );
//   }
// }
//
// // import 'package:dio/dio.dart';
// // import '../caching_utils/caching_utils.dart';
// //
// // class NetworkUtils {
// //   static const String _baseURL = 'http://babycradleapp.runasp.net/api/';
// //   static late Dio _dio;
// //
// //   static Future<void> init() async {
// //     _dio = Dio();
// //     _dio.options.baseUrl = _baseURL;
// //     _dio.options.validateStatus = (v) => v! < 500;
// //   }
// //
// //   static Future<Response<dynamic>> post(
// //       String path, {
// //         Object? data,
// //         Map<String, dynamic>? headers,
// //       }) async {
// //     if (headers == null && CachingUtils.isLogged) {
// //       headers = {'Authorization': 'Bearer ${CachingUtils.token}'};
// //     }
// //     return _dio.post(
// //       path,
// //       data: data,
// //       options: Options(headers: headers),
// //     );
// //   }
// //
// //   static Future<Response<dynamic>> patch(
// //       String path, {
// //         Object? data,
// //         Map<String, dynamic>? headers,
// //       }) async {
// //     if (headers == null && CachingUtils.isLogged) {
// //       headers = {"Authorization": "Bearer ${CachingUtils.token}"};
// //     }
// //     return _dio.patch(
// //       path,
// //       data: data,
// //       options: Options(headers: headers),
// //     );
// //   }
// //
// //   static Future<Response<dynamic>> get(
// //       String path, {
// //         Map<String, dynamic>? headers,
// //       }) async {
// //     if (headers == null && CachingUtils.isLogged) {
// //       headers = {'Authorization': 'Bearer ${CachingUtils.token}'};
// //     }
// //     return _dio.get(
// //       path,
// //       options: Options(headers: headers),
// //     );
// //   }
// //
// //   static Future<Response<dynamic>> delete(
// //       String path, {
// //         Map<String, dynamic>? headers,
// //       }) async {
// //     if (headers == null && CachingUtils.isLogged) {
// //       headers = {"Authorization": "Bearer ${CachingUtils.token}"};
// //     }
// //     return _dio.delete(
// //       path,
// //       options: Options(headers: headers),
// //     );
// //   }
// // }
import 'package:dio/dio.dart';
import '../caching_utils/caching_utils.dart';

class NetworkUtils {
  static const String _baseURL = 'http://babycradleapp.runasp.net/api/';
  static Dio? _dio;

  // Initialization Method
  static Future<void> init() async {
    _dio = Dio();
    _dio!.options.baseUrl = _baseURL;
    _dio!.options.validateStatus = (v) => v! < 500;
  }

  // Internal method to ensure Dio is initialized
  static void _ensureInitialized() {
    if (_dio == null) {
      throw Exception("NetworkUtils.init() must be called before using this class.");
    }
  }

  static Future<Response<dynamic>> post(
      String path, {
        Object? data,
        Map<String, dynamic>? headers,
      }) async {
    _ensureInitialized(); // Ensure Dio is initialized
    return _dio!.post(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response<dynamic>> patch(
      String path, {
        Object? data,
        Map<String, dynamic>? headers,
      }) async {
    _ensureInitialized(); // Ensure Dio is initialized
    if (headers == null && CachingUtils.isLogged) {
      headers = {"Authorization": "Bearer ${CachingUtils.token}"};
    }
    return _dio!.patch(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response<dynamic>> get(
      String path, {
        Map<String, dynamic>? headers,
      }) async {
    _ensureInitialized(); // Ensure Dio is initialized
    if (headers == null && CachingUtils.isLogged) {
      headers = {'Authorization': 'Bearer ${CachingUtils.token}'};
    }
    return _dio!.get(
      path,
      options: Options(headers: headers),
    );
  }

  static Future<Response<dynamic>> delete(
      String path, {
        Map<String, dynamic>? headers,
      }) async {
    _ensureInitialized(); // Ensure Dio is initialized
    if (headers == null && CachingUtils.isLogged) {
      headers = {"Authorization": "Bearer ${CachingUtils.token}"};
    }
    return _dio!.delete(
      path,
      options: Options(headers: headers),
    );
  }
}