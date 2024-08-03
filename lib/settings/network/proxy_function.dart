import 'package:flutter/material.dart';
import 'package:pillcity/common/i18n_function/i18n_function.dart';
import 'package:pillcity/common/network/network_enum_status.dart';
import 'package:pillcity/common/preferences.dart';
import 'package:pillcity/data/global.dart';

class ProxyFunction {
  BuildContext? context;

  String? validateIp(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length < 7 ||
        value.length > 39 ||
        (!(value.contains(".") && RegExp(r"^[0-9.]+$").hasMatch(value)) ||
            (value.contains(":") &&
                RegExp(r"^[ZA-ZZa-z0-9.:]+$").hasMatch(value)))) {
      return tr('setting.network.iperr');
    }
    return null;
  }

  String? validatePort(String? value) {
    if (value == null || value.isEmpty || value.length > 5) {
      return tr('setting.network.porterr');
    }
    int portnum = int.parse(value);
    if (portnum <= 0 || portnum > 65535) {
      return tr('setting.network.porterr');
    }
    return null;
  }

  String? validateTimeout(String? value) {
    if (value == null || value.isEmpty || value.length > 2) {
      return tr('setting.network.timeouterr');
    }
    int timeout = int.parse(value);
    if (timeout < 5 || timeout > 60) {
      return tr('setting.network.timeouterr');
    }
    return null;
  }

  NetworkProxyMode loadProxyMode() {
    if (g_proxy[0] == 'http') {
      return NetworkProxyMode.http;
    } else {
      return NetworkProxyMode.defaultMode;
    }
  }

  Future<bool> willPop(NetworkProxyMode? mode, String ip, String port,
      bool chkCert, String timeout) {
    if (mode != null) {
      if (mode == NetworkProxyMode.http) {
        g_proxy[0] = 'http';
      } else {
        g_proxy[0] = '';
      }
    } else {
      g_proxy[0] = '';
    }
    g_proxy[1] = (validateIp(ip) != null) ? '' : ip.toUpperCase();
    g_proxy[2] = (validatePort(port) != null) ? '' : port;
    if (g_proxy[1].isEmpty || g_proxy[2].isEmpty) {
      g_proxy[0] = '';
    }
    g_proxy[3] = chkCert ? '1' : '';
    sharedPreferencesSet('proxy', g_proxy);
    int timeoutSec =
        (validateTimeout(timeout) != null) ? 10000 : int.parse(timeout) * 1000;
    g_networkTimeout = [timeoutSec, timeoutSec];
    sharedPreferencesSet('networkTimeout', g_networkTimeout);
    // Navigator.pop(context!);
    return Future.value(false);
  }
}
