import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pill_city/common/i18n_function/i18n_function.dart';
import 'package:pill_city/common/preferences.dart';

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
            child: Text(language[1]),
            value: language[0],
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
