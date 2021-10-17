import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pill_city/common/network/network_delegate.dart';
import 'package:pill_city/common/network/network_enum_status.dart';
import 'package:pill_city/common/network/network.dart';
import 'package:pill_city/common/network/network_error.dart';
import 'package:pill_city/data_moudle/data_post.dart';
import 'package:pill_city/home/home_data_response.dart';

abstract class HomeFunctionDelegate {
  void onCommunicating(NetworkStatus status);
}

class HomeFunction implements NetworkDelegate {
  HomeFunctionDelegate? delegate;
  Network net = Network();
  BuildContext? context;

  HomeFunction() {
    net.delegate = this;
  }

  int showProgressBar(bool showing, NetworkStatus status) {
    if (status == NetworkStatus.start || status == NetworkStatus.response) {
      if (showing == false) {
        return 1;
      }
    } else if (showing == true) {
      return 0;
    }
    return -1;
  }

  void getTimeline() {
    if (delegate != null) {
      delegate!.onCommunicating(NetworkStatus.start);
    }
    net.gjson(false, 'https://api.pill.city/api/home', null);
  }

  @override
  bool networkOnRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    if (delegate != null) {
      delegate!.onCommunicating(NetworkStatus.request);
    }
    return true;
  }

  @override
  void networkOnResponse(dynamic response, ResponseInterceptorHandler handler) {
    if (delegate != null) {
      delegate!.onCommunicating(NetworkStatus.response);
    }
    HomeDataResponse data = HomeDataResponse(response);
    // TODO: 資訊流資料
    for (DataPost post in data.posts) {
      print(post.content);
    }
  }

  @override
  void networkOnError(
      NetworkError errorInfos, ErrorInterceptorHandler? handler) {
    if (delegate != null) {
      delegate!.onCommunicating(NetworkStatus.error);
    }
    if (context != null) {
      ScaffoldMessenger.of(context!).clearSnackBars();
      String alertInfo = errorInfos.localizedMessage();
      ScaffoldMessenger.of(context!)
          .showSnackBar(SnackBar(content: Text(alertInfo)));
    }
  }
}
