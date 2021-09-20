import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

abstract class NetworkDelegate {
  bool networkOnRequest(
      RequestOptions options, RequestInterceptorHandler handler);
  void networkOnResponse(String response, ResponseInterceptorHandler handler);
  void networkOnError(String error, ErrorInterceptorHandler? handler);
}

class Network {
  NetworkDelegate? delegate;
  bool _loadingDialogVisible = false;
  final Dio _dio = Dio();
  Response? response;

  Network() {
    _dio.options.connectTimeout = 5000; // 連線伺服器超時時間（毫秒）
    _dio.options.receiveTimeout = 3000; // 接收資料的最長時限（毫秒）
    _dio.options.baseUrl = 'https://api.pill.city';
    _dio.options.contentType = "application/json";
    // 設定代理伺服器
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.2.100:6152";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
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
      onResponse: (dynamic response, ResponseInterceptorHandler handler) {
        if (delegate != null) {
          delegate!.networkOnResponse(response.toString(), handler);
        }
      },
      onError: (DioError error, ErrorInterceptorHandler handler) {
        if (delegate != null) {
          delegate!.networkOnError(error.message, handler);
        }
      },
    ));
  }

  Future<void> postJson(String url, Map<String, dynamic>? parameters) async {
    try {
      String jsonStr = jsonEncode(parameters);
      response = await _dio.post(url, data: jsonStr);
    } catch (e) {
      if (delegate != null) {
        delegate!.networkOnError(e.toString(), null);
      }
    }
  }

  Future<void> post(String url, Map<String, dynamic>? parameters) async {
    try {
      Response response = await _dio.post(url, data: parameters);
      dynamic data = response.data;
      print('dynamic data');
      print(data.toString());
    } catch (e) {
      print('e');
      print(e);
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
