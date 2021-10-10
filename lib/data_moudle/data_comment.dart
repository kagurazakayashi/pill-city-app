import 'package:pill_city/data_moudle/data_author.dart';

class Comment {
  late List<Comment> comments = <Comment>[]; // 子評論
  late String id; // "8a7e7fad-b818-4f47-a4bd-f755a93722dc"
  late int created_at_seconds;
  late DataAuthor author;
  late String content;
  late bool deleted;
  late List media_urls;

  Comment(Map<String,dynamic> data) {
    if (data.containsKey('comments')) {
      for (var e in (data['comments'] as List)) {
        Comment comment = Comment(e);
        comments.add(comment);
      }
    }
    id = data['id'];
    created_at_seconds = data['created_at_seconds'];
    author = DataAuthor(data['author']);
    content = data['content'];
    deleted = data['deleted'];
    media_urls = data['media_urls'];
  }
}