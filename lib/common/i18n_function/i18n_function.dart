import 'package:flutter_translate/flutter_translate.dart';
import 'package:pill_city/data/i18n.dart';

String g_language = 'zh';

String tr(String key) {
  List tarr = [translate('loc')];
  tarr.addAll(key.split("."));
  String returnstr = "";
  Map i18nMap = i18ndata;
  for (var i = 0; i < tarr.length; i++) {
    if (i18nMap.containsKey(tarr[i])) {
      if (tarr.length - 1 == i) {
        returnstr = i18nMap[tarr[i]];
      } else {
        i18nMap = i18nMap[tarr[i]];
      }
    } else {
      return key;
    }
  }
  return returnstr;
}
