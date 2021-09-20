import 'package:flutter/material.dart';
import 'package:pill_city/welcome/welcome_view_controller.dart';
import 'package:pill_city/welcome/welcome_function.dart';

class WelcomeView extends State<WelcomeViewController> {
  WelcomeFunction f = WelcomeFunction();
  String _version = "";

  @override
  void initState() {
    super.initState();
    getVersion();
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
    String subTitle = '再一次与你关心的人分享喜悦\n并探索属于你的热爱';
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
                  child: const Text("　登录　"),
                  onPressed: () {
                    f.toLoginPage(context);
                  },
                ),
                TextButton(onPressed: () {}, child: const Text("使用条款"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
