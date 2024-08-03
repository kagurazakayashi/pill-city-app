import 'dart:core';

import 'package:pillcity/common/i18n_function/i18n_function.dart';

class NetworkError {
  String type = 'other';
  int code = -1;
  String message = '';

  NetworkError(String msg) {
    message = msg;
  }

  String localizedMessage() {
    String alertInfo = tr('network.error') + tr('network.$type');
    if (type == 'response' && code > 0) {
      alertInfo += tr('network.code') + code.toString();
    }
    return alertInfo;
  }
}
