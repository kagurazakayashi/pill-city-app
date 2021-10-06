import 'dart:convert';

class HomeDataResponse {
  LoginDataResponse(String response) {
    List<dynamic> jsonResponse = jsonDecode(response);

    // accessToken = chk(jsonResponse, 'access_token');
  }
}
