import 'package:flutter/material.dart';
import 'package:pillcity/common/preferences.dart';
import 'package:pillcity/data/global.dart';

abstract class I18nSwitchDelegate {
  i18nSwitchDelegateOnChange(String from, String to);
}

class I18nSwitch {
  I18nSwitchDelegate? delegate;
  BuildContext? context;
  List<List<String>> languages = [
    ["en", "English"],
    ["zh_Hans", "简体中文"],
    ["zh_Hant", "繁體中文"],
    ["ja", "日本語"],
  ];

  PopupMenuButton popupMenuButton() {
    return PopupMenuButton(
      icon: const Icon(Icons.translate),
      onSelected: (dynamic value) {
        String from = g_language;
        String to = value;
        if (delegate != null) {
          delegate!.i18nSwitchDelegateOnChange(from, to);
          // 應在實現方法中執行以下內容：
          // setState(() {
          //   changeLocale(context, to);
          //   g_language = to;
          // });
        }
        // print(from + " -> " + to);
        saveConfig(to);
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<dynamic>> items = [];
        for (List<String> language in languages) {
          items.add(PopupMenuItem(
            value: language[0],
            child: Text(language[1]),
          ));
        }
        return items;
      },
    );
  }

  void loadConfig() async {
    String? newlang = await sharedPreferencesGetString('language');
    if (delegate != null && newlang != null) {
      delegate!.i18nSwitchDelegateOnChange('', newlang);
    }
  }

  void saveConfig(String to) {
    sharedPreferencesSet('language', to);
  }
}
