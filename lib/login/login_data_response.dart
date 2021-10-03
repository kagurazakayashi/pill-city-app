import 'dart:convert';

class LoginDataResponse {
  String plainTextOnErr = '';
  String accessToken = '';

  LoginDataResponse(String response) {
    Map<String, dynamic> jsonResponse = <String, dynamic>{};
    try {
      jsonResponse = jsonDecode(response);
    } on FormatException {
      // catch (e)
      plainTextOnErr = response;
      return;
    }
    try {
      accessToken = jsonResponse['access_token'];
    } catch (e) {
      plainTextOnErr = response;
      print(e);
      return;
    }
  }
}
