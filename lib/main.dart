import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:package_info/package_info.dart';
import 'package:pill_city/bottom_navigation/bottom_navigation_view_controller.dart';
import 'package:pill_city/common/preferences.dart';
import 'package:pill_city/common/session.dart';
import 'package:pill_city/common/i18n_function/i18n_function.dart';
import 'package:pill_city/data/global.dart';
import 'package:pill_city/welcome/welcome_view_controller.dart';

Future<void> main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'zh_Hans',
      supportedLocales: ['en', 'zh_Hans', 'zh_Hant', 'ja']);
  runApp(LocalizedApp(delegate, const PillCityAPP()));
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class PillCityAPP extends StatelessWidget {
  const PillCityAPP({Key? key}) : super(key: key);

  // 此部件是應用程式的根。
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate,
        const FallbackCupertinoLocalisationsDelegate(),
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: '',
      theme: ThemeData(
        // 這是應用程序的主題。
        // 嘗試使用“flutter run”來執行應用程式。您將看到應用程式有一個藍色工具列。然後，在不退出應用程式的情況下，嘗試將下麵的primarySwatch更改為Colors.green，然後呼叫“hot reload”（在執行“flutter run”的控制檯中按“r”，或將更改儲存到Flutter IDE中的“hot reload”）。請注意，計數器沒有重置回零；應用程式未重新啟動。
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // 此小部件是應用程式的主頁。它是有狀態的，這意味著它有一個狀態物件（定義如下），其中包含影響其外觀的欄位。
  // 此類是狀態的配置。它儲存由父級（本例中為應用程式小部件）提供並由狀態的構建方法使用的值（本例中為標題）。小部件子類中的欄位始終標記為“final”。

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Session _session = Session();

  @override
  void initState() {
    super.initState();
    changeLocale(context, g_language);
    loadSetting();
    chkLogin();
  }

  void loadSetting() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    g_version = [
      packageInfo.version,
      packageInfo.buildNumber,
      packageInfo.packageName,
      packageInfo.appName,
    ];
    List<String>? proxySet = await sharedPreferencesGetList('proxy');
    if (proxySet != null && proxySet.length == g_proxy.length) {
      g_proxy = proxySet;
    }
    g_ua =
        "PillCityAPP/${g_version[0]} (${Platform.operatingSystem}/${Platform.operatingSystemVersion})";
    print(g_ua);
  }

  // 檢查本地是否有登入狀態的記錄
  void chkLogin() async {
    bool isLocalLogin = await _session.isLocalLogin();
    if (isLocalLogin) {
      // 移動到主畫面
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavigationViewController()),
          (route) => false);
    } else {
      // Navigator.pushReplacementNamed(context, WelcomeViewController, (route) => false)(
      //   context,
      //   MaterialPageRoute(builder: (context) => const WelcomeViewController()),
      // );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const WelcomeViewController()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 每次呼叫setState時都會重新執行此方法，例如，上面的_incrementCounter方法。
    // Flutter 框架已經過最佳化，可以快速地重新執行構建方法，因此您可以只重建任何需要更新的內容，而不必單獨更改小部件的例項。
    return const Text("");
  }
}
