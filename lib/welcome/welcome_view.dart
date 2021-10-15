import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pill_city/common/i18n_function/i18n_function.dart';
import 'package:pill_city/common/i18n_function/i18n_switch.dart';
import 'package:pill_city/welcome/welcome_view_controller.dart';
import 'package:pill_city/welcome/welcome_function.dart';

class WelcomeView extends State<WelcomeViewController>
    implements I18nSwitchDelegate {
  WelcomeFunction f = WelcomeFunction();
  String _version = "";
  final I18nSwitch _langSwitch = I18nSwitch();
  PopupMenuButton? langPopMenuBtn;

  @override
  void initState() {
    super.initState();
    langPopMenuBtn = _langSwitch.popupMenuButton();
    _langSwitch.delegate = this;
    _langSwitch.loadConfig();
    getVersion();
  }

  @override
  void dispose() {
    _langSwitch.delegate = null;
    super.dispose();
  }

  void getVersion() async {
    String packageInfo = await f.getVersion();
    setState(() {
      _version = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double bottomBarHeight = 150;
    double versionTop = screenSize.height - bottomBarHeight - 20;
    double subTitleTop = (screenSize.height - bottomBarHeight) / 2 - 30;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    String subTitle = tr("welcome.slogan");
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return Material(
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Image(
                image: const AssetImage('images/welcome.png'),
                width: screenSize.width,
                height: screenSize.height - bottomBarHeight,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, statusBarHeight, 10, 0),
                child: Row(
                  children: <Widget>[
                    const Spacer(),
                    IconButton(
                      tooltip: tr("welcome.proxy"),
                      icon: const Icon(Icons.settings_ethernet),
                      onPressed: () {
                        f.toProxyPage(context);
                      },
                    ),
                    langPopMenuBtn!,
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                height: 20,
                margin: EdgeInsets.only(top: versionTop),
                child: Row(
                  children: <Widget>[
                    const Expanded(child: SizedBox()),
                    Text(
                      _version,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                height: 60,
                margin: EdgeInsets.only(top: subTitleTop),
                child: Column(
                  children: <Widget>[
                    Text(
                      subTitle,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w200,
                        height: 1.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: screenSize.width,
            height: bottomBarHeight,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  child: Text("  " + tr("welcome.login") + "  "),
                  onPressed: () {
                    f.toLoginPage(context);
                  },
                ),
                TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(tr("welcome.license")))
              ],
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
