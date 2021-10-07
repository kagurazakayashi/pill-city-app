import 'package:flutter/material.dart';
import 'package:pill_city/common/i18n_function.dart';
import 'package:pill_city/common/i18n_switch.dart';
import 'package:pill_city/login/login_data_request.dart';
import 'package:pill_city/login/login_view_controller.dart';
import 'package:pill_city/login/login_function.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoginView extends State<LoginViewController>
    implements I18nSwitchDelegate {
  final LoginFunction _f = LoginFunction();
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _showPassword = false;
  final bool _nameFocus = true;
  final FocusNode _unameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final I18nSwitch _langSwitch = I18nSwitch();
  PopupMenuButton? langPopMenuBtn;

  @override
  void initState() {
    super.initState();
    langPopMenuBtn = _langSwitch.popupMenuButton();
    _langSwitch.delegate = this;
  }

  @override
  void dispose() {
    _langSwitch.delegate = null;
    _unameFocusNode.dispose();
    _pwdFocusNode.dispose();
    _unameController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void btnLogin() {
    _f.btnLogin(LoginDataRequest(_unameController.text, _pwdController.text));
  }

  @override
  Widget build(BuildContext context) {
    _f.context ??= context;
    String strUserName = tr('login.username');
    String strPassword = tr('login.password');
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('login.signin')),
        backgroundColor: Colors.red[400],
        actions: <Widget>[
          langPopMenuBtn!,
        ],
      ),
      body: ListView(
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
                  children: [
                    Text(
                      tr('login.welcome'),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    Text(
                      tr('login.appname'),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
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
            child: Form(
              key: _formKey,
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
                    validator: (value) {
                      return _f.validateUsername(value);
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                  ),
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
                      validator: (value) {
                        return _f.validatePassword(value);
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: _f.btnForgetPassword,
                              child: Text(tr('login.forgot')),
                            ),
                            TextButton(
                              onPressed: _f.btnRegister,
                              child: Text(tr('login.signup')),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: btnLogin,
                              child: Text(' ' + tr('login.signin') + ' '),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  i18nSwitchDelegateOnChange(String from, String to) {
    setState(() {
      changeLocale(context, to);
      g_language = to;
    });
  }
}
