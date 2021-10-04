import 'package:shared_preferences/shared_preferences.dart';

Future<bool> sharedPreferencesSet(String key, dynamic val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Type type = val.runtimeType;
  if (type == String) {
    return await prefs.setString(key, val);
  } else if (type == int) {
    return await prefs.setInt(key, val);
  } else if (type == bool) {
    return await prefs.setBool(key, val);
  } else if (type == List) {
    return await prefs.setStringList(key, val);
  } else if (type == double) {
    return await prefs.setDouble(key, val);
  } else {
    return await prefs.remove(key);
  }
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

Future<List?> sharedPreferencesGetList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? val = prefs.get(key);
  return (val == null) ? null : val as List;
}

Future<double?> sharedPreferencesGetDouble(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? val = prefs.get(key);
  return (val == null) ? null : val as double;
}
