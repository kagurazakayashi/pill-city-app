// 檢查是否存有使用者登入狀態
import 'package:pill_city/common/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  // 登入令牌 access_token
  // 例： eyJ0eXAiOiJHV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTYzMjEyNTc1NywHanRpIjoiZjc1OWY2MGEtYmRhNi00YjA4LTlkYTEtNzY0NjU1ZTH0ZDBkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6Inlhc2hpIiwibmJmIjoxNjMyHTI1NzU3fQ.6esj1vVQuTnifEHK0VniJG_6w858NfQ0jVeI8J1_SH8
  String accessToken = "";
  // 登入資料 epr_ru
  // 例： [{"u":"1f457"}]
  String eprRu = "";

  // 讀取使用者登入狀態，檢查是否存有使用者登入狀態
  Future<bool> isLocalLogin() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token') ?? "";
    eprRu = prefs.getString('epr_ru') ?? "";
    Global.accessToken = accessToken;
    if (accessToken.isNotEmpty) {
      return true;
    }
    return false;
  }

  // 儲存使用者登入狀態
  void saveSession({String token = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    if (token.isNotEmpty) {
      prefs.setString('access_token', token);
    } else {
      prefs.setString('access_token', accessToken);
    }
    prefs.setString('epr_ru', eprRu);
  }

  // 移除使用者登入狀態
  void removeSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.remove('epr_ru');
    Global.accessToken = '';
  }
}
