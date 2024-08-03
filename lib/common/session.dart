// 檢查是否存有使用者登入狀態
import 'package:pillcity/data/global.dart';
import 'package:pillcity/common/preferences.dart';

class Session {
  // 登入令牌 access_token
  // 例： eyJ0eXAiOiJHV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTYzMjEyNTc1NywHanRpIjoiZjc1OWY2MGEtYmRhNi00YjA4LTlkYTEtNzY0NjU1ZTH0ZDBkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6Inlhc2hpIiwibmJmIjoxNjMyHTI1NzU3fQ.6esj1vVQuTnifEHK0VniJG_6w858NfQ0jVeI8J1_SH8
  String accessToken = "";
  // 登入資料 epr_ru
  // 例： [{"u":"1f457"}]
  String eprRu = "";

  // 讀取使用者登入狀態，檢查是否存有使用者登入狀態
  Future<bool> isLocalLogin() async {
    accessToken = await sharedPreferencesGetString('access_token') ?? "";
    eprRu = await sharedPreferencesGetString('epr_ru') ?? "";
    g_accessToken = accessToken;
    if (accessToken.isNotEmpty) {
      return true;
    }
    return false;
  }

  // 儲存使用者登入狀態
  void saveSession({String token = ''}) {
    if (token.isNotEmpty) {
      g_accessToken = token;
      sharedPreferencesSet('access_token', token);
    } else {
      g_accessToken = accessToken;
      sharedPreferencesSet('access_token', accessToken);
    }
    sharedPreferencesSet('epr_ru', eprRu);
  }

  // 移除使用者登入狀態
  void removeSession() {
    sharedPreferencesSet('access_token', null);
    sharedPreferencesSet('epr_ru', null);
    g_accessToken = '';
  }
}
