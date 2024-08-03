import 'package:dio/dio.dart';
import 'package:pillcity/common/network/network_error.dart';

abstract class NetworkDelegate {
  bool networkOnRequest(
      RequestOptions options, RequestInterceptorHandler handler);
  void networkOnResponse(dynamic response, ResponseInterceptorHandler handler);
  void networkOnError(
      NetworkError errorInfos, ErrorInterceptorHandler? handler);
}
