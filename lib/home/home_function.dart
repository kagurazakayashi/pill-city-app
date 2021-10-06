import 'package:dio/src/options.dart';
import 'package:dio/src/interceptor.dart';
import 'package:flutter/material.dart';
import 'package:pill_city/common/global.dart';
import 'package:pill_city/common/network.dart';

class HomeFunction implements NetworkDelegate {
  Network net = Network();
  late BuildContext context;

  HomeFunction() {
    net.delegate = this;
  }

  void getTimeline() {
    net.gjson(false,'https://api.pill.city/api/home', null);
  }

  @override
  bool networkOnRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    return true;
  }

  @override
  void networkOnResponse(String response, ResponseInterceptorHandler handler) {
    // LoginDataResponse data = LoginDataResponse(response);
    print(response);
  }

  @override
  void networkOnError(String error, ErrorInterceptorHandler? handler) {
    ScaffoldMessenger.of(context).clearSnackBars();
    String alertInfo = '网络操作失败: ' + error;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(alertInfo)));
  }
}
