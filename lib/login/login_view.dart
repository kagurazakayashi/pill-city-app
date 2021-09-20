import 'package:flutter/material.dart';
import 'package:pill_city/login/login_data_request.dart';
import 'package:pill_city/login/login_view_controller.dart';
import 'package:pill_city/login/login_function.dart';

class LoginView extends State<LoginViewController> {
  final LoginFunction _f = LoginFunction();
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _showPassword = false;
  final bool _nameFocus = true;

  @override
  void initState() {
    super.initState();
  }

  void btnLogin() {
    _f.btnLogin(LoginDataRequest(_unameController.text, _pwdController.text));
  }

  @override
  Widget build(BuildContext context) {
    _f.context = context;
    String strUserName = '用户名';
    String strPassword = '密码';
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: '登录',
            onPressed: btnLogin,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Image(
                    image: AssetImage('images/pill.png'),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 55.0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Welcome back to',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    Text(
                      'Pill City',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                TextFormField(
                    autofocus: _nameFocus,
                    controller: _unameController,
                    decoration: InputDecoration(
                      labelText: strUserName,
                      hintText: strUserName,
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _unameController.text = '';
                            _pwdController.text = '';
                          });
                        },
                      ),
                    ),
                    validator: (v) {
                      return _f.chkUserName(v);
                    }),
                TextFormField(
                  controller: _pwdController,
                  autofocus: !_nameFocus,
                  decoration: InputDecoration(
                    labelText: strPassword,
                    hintText: strPassword,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showPassword,
                  validator: (v) {
                    return _f.chkPassword(v);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: _f.btnForgetPassword,
                            child: const Text('忘记密码'),
                          ),
                          TextButton(
                            onPressed: _f.btnRegister,
                            child: const Text('用户注册'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: btnLogin,
                            child: const Text('　登录　'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
