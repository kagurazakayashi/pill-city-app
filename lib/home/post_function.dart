import 'package:pill_city/common/i18n_function/i18n_function.dart';
import 'package:pill_city/data_moudle/data_circles.dart';

class PostFunction {
  /// 根據貼文的 [circles] 欄位列出所有分享圈子的集合字串，例如 "圈子1, 圈子2"
  String circlesString(List<Circle> circles) {
    String circleNames = '';
    bool first = true;
    for (Circle circle in circles) {
      if (first) {
        first = false;
      } else {
        circleNames += ", ";
      }
      circleNames += circle.name;
    }
    return circleNames;
  }

  /// 根據 [timeStamp] 獲取時間資訊字串，例如「3 分鐘前」或具體日期。
  String timeStr(int timeStamp) {
    // 輸入時間
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String dtStr = dt.toString();
    // 當前時間
    int nowTimeStamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    // 計算時間差，大於1天顯示具體時間，否則顯示差異時間
    int distance = nowTimeStamp - timeStamp;
    if (distance <= 60) {
      // 一分鐘內顯示為剛剛
      return tr("time.just");
    } else if (distance <= 3600) {
      // x 分鐘前
      int tInt = (distance / 60).floor();
      String tStr = tInt > 1 ? tr("time.minutes") : tr("time.minute");
      return tInt.toString() + " " + tStr + tr("time.ago");
    } else if (distance <= 86400) {
      // x 小時前
      int tInt = (distance / 60 / 60).floor();
      String tStr = tInt > 1 ? tr("time.hours") : tr("time.hour");
      return tInt.toString() + " " + tStr + tr("time.ago");
    } else if (distance <= 172800) {
      // x 天前
      int tInt = (distance / 60 / 60 / 24).floor();
      String tStr = tInt > 1 ? tr("time.days") : tr("time.day");
      return tInt.toString() + " " + tStr + tr("time.ago");
    } else if (DateTime.fromMillisecondsSinceEpoch(nowTimeStamp * 1000).year ==
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).year) {
      // 同年的就不寫年份了
      return '${dt.month.toString().padLeft(2, '0')}${tr("time.datesym")}${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } else {
      // 顯示完整日期字串
      return dtStr = dtStr.split('.')[0];
    }
  }
}
