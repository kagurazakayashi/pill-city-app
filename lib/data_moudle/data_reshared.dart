import 'package:pill_city/data_moudle/data_author.dart';

class DataReshared {
  late String id; // "yashi"
  late int created_at_seconds; // 1632125699
  late DataAuthor author;
  late String content; // "白絲白絲"
  late List media_urls;
  late bool deleted;

  DataReshared(Map<String,dynamic> data) {
    id = data['id'];
    created_at_seconds = data['created_at_seconds'];
    author = DataAuthor(data['author']);
    content = data['content'];
    media_urls = data['media_urls'];
    deleted = data['deleted'];
  }
}