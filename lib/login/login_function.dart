import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pillcity/bottom_navigation/bottom_navigation_view_controller.dart';
import 'package:pillcity/common/i18n_function/i18n_function.dart';
import 'package:pillcity/common/network/network.dart';
import 'package:pillcity/common/network/network_delegate.dart';
import 'package:pillcity/common/network/network_error.dart';
import 'package:pillcity/common/session.dart';
import 'package:pillcity/login/login_data_request.dart';
import 'package:pillcity/login/login_data_response.dart';
import 'package:pillcity/settings/network/proxy_view_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginFunction implements NetworkDelegate {
  Network net = Network();
  BuildContext? context;
  final Session _sess = Session();

  LoginFunction() {
    net.delegate = this;
  }

  String? validateUsername(String? value) {
    String lengthErr = tr('login.usernamelen');
    if (value!.isEmpty) {
      return lengthErr;
    }
    int valLen = value.length;
    if (valLen < 3 || valLen > 16) {
      return lengthErr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    String lengthErr = tr('login.passwordlen');
    if (value!.isEmpty) {
      return lengthErr;
    }
    int valLen = value.length;
    if (valLen < 6 || valLen > 512) {
      return lengthErr;
    }
    return null;
  }

  void launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (kDebugMode) {
      print('[ERROR] Could not launch $uri');
    }
  }

  void btnForgetPassword() {
    launchURL('https://pill.city/');
  }

  void btnRegister() {
    launchURL('https://pill.city/signup');
  }

  void btnLogin(LoginDataRequest data) {
    // 顯示處理中對話方塊
    net.showLoadingDialog(context!, '${tr('login.loggingin')}...');
    // 移除使用者登入狀態
    _sess.removeSession();
    // 向伺服器傳送登入請求 -> 等待網路類呼叫 NetworkDelegate
    net.gjson(true, data.url, data.toMap());
  }

  void toProxyPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProxyViewController()));
  }

  @override
  bool networkOnRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    return true;
  }

  @override
  void networkOnResponse(dynamic response, ResponseInterceptorHandler handler) {
    net.showLoadingDialog(context!, "");
    LoginDataResponse data = LoginDataResponse(response);
    if (data.accessToken.isNotEmpty) {
      // 如果伺服器正確返回了令牌，將令牌儲存到本地
      _sess.accessToken = data.accessToken;
      _sess.saveSession();
      // 移動到主畫面
      Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(
              builder: (context) => const BottomNavigationViewController()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context!).clearSnackBars();
      String alertInfo = tr('login.loginfailed') + data.accessToken;
      ScaffoldMessenger.of(context!)
          .showSnackBar(SnackBar(content: Text(alertInfo)));
    }
    net.showLoadingDialog(context!, ""); // 關閉等待對話方塊
  }

  @override
  void networkOnError(
      NetworkError errorInfos, ErrorInterceptorHandler? handler) {
    net.showLoadingDialog(context!, '');
    ScaffoldMessenger.of(context!).clearSnackBars();
    String alertInfo = errorInfos.localizedMessage();
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(alertInfo)));
    if (kDebugMode) {
      print(errorInfos.message);
    }
  }
}
