import 'package:dio/dio.dart';
import '../cache/cache_helper.dart';
import 'end_point.dart';

class ApiInterceptor extends Interceptor {

  //Method called whenever a request is about to be sent.
  // It allows modifying the request before it is sent to the server.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.token] =
    CacheHelper().getData(key: ApiKey.token) != null
        ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}'
        : null;
    super.onRequest(options, handler);
  }
}