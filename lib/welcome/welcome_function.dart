import 'package:flutter/material.dart';
import 'package:pillcity/login/login_view_controller.dart';
import 'package:pillcity/settings/network/proxy_view_controller.dart';

class WelcomeFunction {
  void toLoginPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginViewController()));
  }

  void toProxyPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProxyViewController()));
  }
}
