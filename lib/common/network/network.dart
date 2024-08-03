import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pillcity/common/network/network_delegate.dart';
import 'package:pillcity/common/network/network_error.dart';
import 'package:pillcity/data/global.dart';

class Network {
  NetworkDelegate? delegate;
  bool _loadingDialogVisible = false;
  final Dio _dio = Dio();
  Response? response;

  Network() {
    _dio.options.connectTimeout =
        Duration(milliseconds: g_networkTimeout[0]); // 連線伺服器超時時間（毫秒）
    _dio.options.receiveTimeout =
        Duration(milliseconds: g_networkTimeout[1]); // 接收資料的最長時限（毫秒）
    _dio.options.baseUrl = g_apiHost;
    _dio.options.contentType = "application/json; charset=utf-8";
    _dio.options.responseType = ResponseType.plain;
    // 設定代理伺服器
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.findProxy = (uri) {
          return "PROXY ${g_proxy[1]}:${g_proxy[2]}";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return g_proxy[3].isEmpty;
        };
        return client;
      },
    );
    // 設定監聽事件
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (delegate != null) {
          if (delegate!.networkOnRequest(options, handler)) {
            return handler.next(options);
          }
        } else {
          return handler.next(options);
        }
      },
      onResponse:
          (Response<dynamic> response, ResponseInterceptorHandler handler) {
        // print("::response:" + response.toString());
        if (delegate != null) {
          delegate!.networkOnResponse(response.data, handler);
        }
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        if (delegate != null) {
          NetworkError errorInfos = NetworkError(error.message ?? "");
          if (error.response != null && error.response!.statusCode != null) {
            errorInfos.code = error.response!.statusCode!;
          }
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              errorInfos.type = 'connectionTimeout';
              break;
            case DioExceptionType.sendTimeout:
              errorInfos.type = 'sendTimeout';
              break;
            case DioExceptionType.receiveTimeout:
              errorInfos.type = 'receiveTimeout';
              break;
            case DioExceptionType.badCertificate:
              errorInfos.type = 'badCertificate';
              break;
            case DioExceptionType.badResponse:
              errorInfos.type = 'badResponse';
              break;
            case DioExceptionType.cancel:
              errorInfos.type = 'cancel';
              break;
            case DioExceptionType.connectionError:
              errorInfos.type = 'connectionError';
              break;
            default:
              errorInfos.type = 'unknown';
              break;
          }
          if (kDebugMode) {
            print(
                '[NETWORK ERROR] [${errorInfos.type}] ${error.requestOptions.uri} : ${error.message}');
          }
          delegate!.networkOnError(errorInfos, handler);
        }
        return handler.next(error);
      },
    ));
  }

  Future<void> gjson(
      bool isPost, String url, Map<String, dynamic>? parameters) async {
    String jsonStr = parameters == null ? "" : jsonEncode(parameters);
    _dio.options.headers.clear();
    _dio.options.headers["Content-Type"] =
        "application/json"; // "multipart/form-data"
    _dio.options.headers["accept-language"] = g_language;
    _dio.options.headers["User-Agent"] = g_ua;
    if (g_accessToken.isNotEmpty) {
      _dio.options.headers["Authorization"] = "Bearer $g_accessToken";
    }
    if (isPost) {
      if (jsonStr.isEmpty) {
        response = await _dio.post(url);
      } else {
        response = await _dio.post(url, data: jsonStr);
      }
    } else {
      response = await _dio.get(url);
    }
  }

  /// 顯示正在載入對話方塊。
  /// [infoText] 是顯示的等待訊息，空字串作為隱藏此等待框。
  void showLoadingDialog(BuildContext context, String infoText,
      {double width = 280}) {
    if (infoText.isEmpty) {
      if (_loadingDialogVisible) {
        _loadingDialogVisible = false;
        Navigator.of(context).pop(true);
      }
    } else {
      _loadingDialogVisible = true;
      showDialog(
        context: context,
        barrierDismissible: false, // 點選遮罩時是否關閉對話方塊
        builder: (context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: width,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const CircularProgressIndicator(
                      value: .8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: Text(infoText),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
