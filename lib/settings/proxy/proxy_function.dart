import 'package:flutter/material.dart';
import 'package:pill_city/common/i18n_function/i18n_function.dart';
import 'package:pill_city/common/network/network_enum_status.dart';
import 'package:pill_city/common/preferences.dart';
import 'package:pill_city/data/global.dart';

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
      return tr('setting.proxy.iperr');
    }
    return null;
  }

  String? validatePort(String? value) {
    if (value == null || value.isEmpty || value.length > 5) {
      return tr('setting.proxy.porterr');
    }
    int portnum = int.parse(value);
    if (portnum <= 0 || portnum > 65535) {
      return tr('setting.proxy.porterr');
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

  Future<bool> willPop(
      NetworkProxyMode? mode, String ip, String port, bool chkCert) {
    if (mode == null ||
        mode == NetworkProxyMode.defaultMode ||
        validateIp(ip) != null ||
        validatePort(port) != null) {}
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
    Navigator.pop(context!);
    return Future.value(false);
  }
}
