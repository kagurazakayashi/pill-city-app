import 'package:pillcity/data_moudle/data_author.dart';

class DataReshared {
  late String id; // "yashi"
  late int createdAtSeconds; // 1632125699
  late DataAuthor author;
  late String content; // "白絲白絲"
  late List mediaURLs;
  late bool deleted;

  DataReshared(Map<String, dynamic> data) {
    id = data['id'];
    createdAtSeconds = data['created_at_seconds'];
    author = DataAuthor(data['author']);
    content = data['content'];
    mediaURLs = data['media_urls'];
    deleted = data['deleted'];
  }
}
