import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pill_city/bottom_navigation/bottom_navigation_view_controller.dart';
import 'package:pill_city/common/global.dart';
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

  bool chkUserNameB(String? v) {
    if (v == null) {
      return false;
    }
    if (v.isEmpty) {
      return false;
    }
    return true;
  }

  String chkUserName(String? v) {
    return chkUserNameB(v) ? '' : '请输入用户名';
  }

  bool chkPasswordB(String? v) {
    if (v == null) {
      return false;
    }
    if (v.isEmpty) {
      return false;
    }
    return true;
  }

  String chkPassword(String? v) {
    return chkPasswordB(v) ? '' : '请输入密码';
  }

  void chkUsernameAndPassword(BuildContext context,
      GlobalKey<FormState> formKey, String username, String password) {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('ERR');
    }
    // if (!chkUserNameB(username) || !chkUserNameB(password)) {
    // ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(const SnackBar(content: Text('用户名或密码不能为空')));
    //   return false;
    // }
    // return true;
  }

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return '用户名不能为空';
    }
    // if...
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return '密码不能为空';
    }
    // if...
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
    net.showLoadingDialog(context!, "正在登录");
    // 向伺服器傳送登入請求 -> 等待網路類呼叫 NetworkDelegate
    net.gjson(true,data.url, data.toMap());
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
      String alertInfo = '登录失败 ' + data.accessToken;
      ScaffoldMessenger.of(context!)
          .showSnackBar(SnackBar(content: Text(alertInfo)));
    }
    net.showLoadingDialog(context!, ""); // 關閉等待對話方塊
  }

  @override
  void networkOnError(String error, ErrorInterceptorHandler? handler) {
    ScaffoldMessenger.of(context!).clearSnackBars();
    String alertInfo = '网络操作失败: ' + error;
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(alertInfo)));
  }
}
