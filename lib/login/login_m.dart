import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Login {
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

  bool chkUsernameAndPassword(
      BuildContext context, String username, String password) {
    if (!chkUserNameB(username) || !chkUserNameB(password)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('用户名或密码不能为空')));
      return false;
    }
    return true;
  }

  void btnForgetPassword() {
    launch('https://pill.city/');
  }

  void btnRegister() {
    launch('https://pill.city/signup');
  }

  void btnLogin(BuildContext context, String username, String password) {
    // 預先檢查輸入
    if (!chkUsernameAndPassword(context, username, password)) {
      return;
    }
    // 顯示處理中對話方塊
    // 網路登入
    // 登入成功
  }
}
