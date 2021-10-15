import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pill_city/login/login_view_controller.dart';
import 'package:pill_city/settings/proxy/proxy_view_controller.dart';

class WelcomeFunction {
  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v' + packageInfo.version + ' build ' + packageInfo.buildNumber;
  }

  void toLoginPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginViewController()));
  }

  void toProxyPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProxyViewController()));
  }
}
