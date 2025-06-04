import 'package:dio/dio.dart';

class ApiClient {
  static const String baseURL = "http://babycradleapp.runasp.net/api";
  final Dio _dio;

  ApiClient() : _dio = Dio(BaseOptions(baseUrl: baseURL));

  Future<Response> get(String path, {String? token}) async {
    return await _dio.get(
      path,
      options: Options(
        headers: _buildHeaders(token: token),
      ),
    );
  }

  Future<Response> post(String path, {dynamic data, String? token}) async {
    return await _dio.post(
      path,
      data: data,
      options: Options(
        headers: _buildHeaders(token: token),
      ),
    );
  }

  Future<Response> put(String path, {dynamic data, String? token}) async {
    return await _dio.put(
      path,
      data: data,
      options: Options(
        headers: _buildHeaders(token: token),
      ),
    );
  }

  Future<Response> delete(String path, {String? token}) async {
    return await _dio.delete(
      path,
      options: Options(
        headers: _buildHeaders(token: token),
      ),
    );
  }

  Map<String, String> _buildHeaders({String? token}) {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}