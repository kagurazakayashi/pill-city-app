import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pill_city/login/login_c.dart';

class Welcome {
  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v' + packageInfo.version + ' build ' + packageInfo.buildNumber;
  }

  void toLoginPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginViewController()));
  }
}
