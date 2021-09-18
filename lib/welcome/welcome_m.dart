import 'package:package_info/package_info.dart';

class Welcome {
  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v' + packageInfo.version + ' build ' + packageInfo.buildNumber;
  }
}
