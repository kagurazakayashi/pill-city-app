import 'dart:convert';

class LoginDataResponse {
  int total = 0;
  int isOK = 0;

  String accessToken = '';

  LoginDataResponse(String response) {
    Map<String, dynamic> jsonResponse = jsonDecode(response);
    accessToken = chk(jsonResponse, 'access_token');
  }

  String chk(Map<String, dynamic> jsonResponse, String key) {
    total++;
    if (!jsonResponse.containsKey(key) || jsonResponse[key] is! String) {
      return '';
    } else {
      isOK++;
      return jsonResponse[key];
    }
  }
}
