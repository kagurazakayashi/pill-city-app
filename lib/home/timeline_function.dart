import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pill_city/common/network/network.dart';
import 'package:pill_city/common/network/network_delegate.dart';
import 'package:pill_city/common/network/network_enum_status.dart';
import 'package:pill_city/common/network/network_error.dart';
import 'package:pill_city/data_moudle/data_post.dart';
import 'package:pill_city/home/home_data_response.dart';

abstract class TimeLineFunctionDelegate {
  void onCommunicating(NetworkStatus status);
  void onUpdate(List<DataPost> posts);
}

class TimelineFunction implements NetworkDelegate {
  BuildContext? context;
  TimeLineFunctionDelegate? delegate;
  Network net = Network();
  void getTimeline() {
    if (delegate != null) {
      delegate!.onCommunicating(NetworkStatus.start);
    }
    net.gjson(false, 'https://api.pill.city/api/home', null);
  }

  TimelineFunction() {
    net.delegate = this;
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
    if (delegate != null) {
      delegate!.onUpdate(data.posts);
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

  int showProgressBar(bool showing, NetworkStatus status) {
    if (status == NetworkStatus.start || status == NetworkStatus.request) {
      if (showing == false) {
        return 1; // 應該改為顯示
      }
    } else if (status == NetworkStatus.response ||
        status == NetworkStatus.error) {
      if (showing == true) {
        return 0; // 應該改為隱藏
      }
    }
    return -1; // 不需要變化
  }
}
