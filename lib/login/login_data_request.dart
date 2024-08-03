class LoginDataRequest {
  String url = '/api/signIn';

  String id;
  String password;

  LoginDataRequest(this.id, this.password);

  Map<String, String> toMap() {
    return {
      "id": id,
      "password": password,
    };
  }
}
