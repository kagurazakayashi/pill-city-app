import 'package:flutter_translate/flutter_translate.dart';
import 'package:pill_city/data/i18n/i18n_en.dart';
import 'package:pill_city/data/i18n/i18n_ja.dart';
import 'package:pill_city/data/i18n/i18n_zhhans.dart';
import 'package:pill_city/data/i18n/i18n_zhhant.dart';

String tr(String key) {
  List tarr = [translate('l')];
  tarr.addAll(key.split("."));
  String returnstr = "";
  Map i18nMap = {
    'en': {},
    'zh_Hans': {},
    'zh_Hant': {},
    'ja': {},
  };
  for (var i = 0; i < tarr.length; i++) {
    if (i18nMap.containsKey(tarr[i])) {
      switch (tarr[i]) {
        case 'en':
          i18nMap[tarr[i]] = i18ndataEn;
          break;
        case 'zh_Hans':
          i18nMap[tarr[i]] = i18ndataZhHans;
          break;
        case 'zh_Hant':
          i18nMap[tarr[i]] = i18ndataZhHant;
          break;
        case 'ja':
          i18nMap[tarr[i]] = i18ndataJa;
          break;
        default:
          break;
      }
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
