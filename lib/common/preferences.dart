import 'package:shared_preferences/shared_preferences.dart';

Future<bool> sharedPreferencesSet(String key, dynamic val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (val != null) {
    Type type = val.runtimeType;
    if (type == String) {
      return await prefs.setString(key, val);
    } else if (type == int) {
      return await prefs.setInt(key, val);
    } else if (type == bool) {
      return await prefs.setBool(key, val);
    } else if (type == double) {
      return await prefs.setDouble(key, val);
    } else {
      String typeStr = type.toString();
      if (typeStr == "List<String>") {
        return await prefs.setStringList(key, val);
      }
      List<String> nStrArr = [];
      if (typeStr == "List<int>") {
        List<int> nArr = val;
        for (int nVal in nArr) {
          nStrArr.add(nVal.toString());
        }
        return await prefs.setStringList(key, nStrArr);
      }
      if (typeStr == "List<double>") {
        List<double> nArr = val;
        for (double nVal in nArr) {
          nStrArr.add(nVal.toString());
        }
        return await prefs.setStringList(key, nStrArr);
      }
      if (typeStr == "List<bool>") {
        List<bool> nArr = val;
        for (bool nVal in nArr) {
          String nStr = nVal ? '1' : '';
          nStrArr.add(nStr);
        }
        return await prefs.setStringList(key, nStrArr);
      }
    }
  }
  return await prefs.remove(key);
}

Future<String?> sharedPreferencesGetString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? val = prefs.get(key);
  return (val == null) ? null : val.toString();
}

Future<int?> sharedPreferencesGetInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? val = prefs.get(key);
  return (val == null) ? null : val as int;
}

Future<bool?> sharedPreferencesGetBool(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? val = prefs.get(key);
  return (val == null) ? null : val as bool;
}

Future<double?> sharedPreferencesGetDouble(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? val = prefs.get(key);
  return (val == null) ? null : val as double;
}

Future<List<String>?> sharedPreferencesGetStringList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? val = prefs.get(key);
  if (val == null) {
    return null;
  }
  List<dynamic>? list = val as List;
  List<String> strList = [];
  if (list.isEmpty) {
    return strList;
  }
  for (dynamic listItem in list) {
    String str = listItem.toString();
    strList.add(str);
  }
  return strList;
}

Future<List<int>?> sharedPreferencesGetIntList(String key) async {
  List<String>? strList = await sharedPreferencesGetStringList(key);
  if (strList == null) {
    return null;
  }
  List<int> nList = [];
  for (String nVal in strList) {
    int tVal = int.parse(nVal);
    nList.add(tVal);
  }
  return nList;
}

Future<List<double>?> sharedPreferencesGetDoubleList(String key) async {
  List<String>? strList = await sharedPreferencesGetStringList(key);
  if (strList == null) {
    return null;
  }
  List<double> nList = [];
  for (String nVal in strList) {
    double tVal = double.parse(nVal);
    nList.add(tVal);
  }
  return nList;
}

Future<List<bool>?> sharedPreferencesGetBoolList(String key) async {
  List<String>? strList = await sharedPreferencesGetStringList(key);
  if (strList == null) {
    return null;
  }
  List<bool> nList = [];
  for (String nVal in strList) {
    bool tVal = nVal.isNotEmpty;
    nList.add(tVal);
  }
  return nList;
}
