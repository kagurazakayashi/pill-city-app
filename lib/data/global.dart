// ignore_for_file: non_constant_identifier_names

String g_apiHost = 'https://api.pill.city';
String g_language = 'zh_Hans';
String g_accessToken = '';
List<String> g_proxy = [
  '', // 0 mode
  '', // 1 ip
  '', // 2 port
  '1', // 3 chkCert
];
List<int> g_networkTimeout = [
  10000, // connectTimeout
  10000, // receiveTimeout
];
List<String> g_version = [
  '', // 0 version
  '', // 1 buildNumber
  '', // 2 packageName
  '', // 3 appName
];
String g_ua = '';
