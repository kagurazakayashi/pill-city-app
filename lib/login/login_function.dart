import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pill_city/bottom_navigation/bottom_navigation_view_controller.dart';
import 'package:pill_city/common/i18n_function.dart';
import 'package:pill_city/common/network.dart';
import 'package:pill_city/common/session.dart';
import 'package:pill_city/login/login_data_request.dart';
import 'package:pill_city/login/login_data_response.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginFunction implements NetworkDelegate {
  Network net = Network();
  BuildContext? context;

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

  void btnForgetPassword() {
    launch('https://pill.city/');
  }

  void btnRegister() {
    launch('https://pill.city/signup');
  }

  void btnLogin(LoginDataRequest data) {
    // 預先檢查輸入
    // if (!chkUsernameAndPassword(context!, data.id, data.password)) {
    //   return;
    // }
    // 顯示處理中對話方塊
    net.showLoadingDialog(context!, tr('login.loggingin') + '...');
    // 向伺服器傳送登入請求 -> 等待網路類呼叫 NetworkDelegate
    net.gjson(true, data.url, data.toMap());
  }

  @override
  bool networkOnRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    return true;
  }

  @override
  void networkOnResponse(String response, ResponseInterceptorHandler handler) {
    net.showLoadingDialog(context!, "");
    LoginDataResponse data = LoginDataResponse(response);
    if (data.accessToken.isNotEmpty) {
      // 如果伺服器正確返回了令牌，將令牌儲存到本地
      Session sess = Session();
      sess.accessToken = data.accessToken;
      sess.saveSession();
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
  void networkOnError(String error, ErrorInterceptorHandler? handler) {
    ScaffoldMessenger.of(context!).clearSnackBars();
    String alertInfo = tr('login.networkerr') + ': ' + error;
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(alertInfo)));
  }
}
