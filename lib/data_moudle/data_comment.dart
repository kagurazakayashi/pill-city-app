import 'package:pillcity/data_moudle/data_author.dart';

class Comment {
  late List<Comment> comments = <Comment>[]; // 子評論
  late String id; // "8a7e7fad-b818-4f47-a4bd-f755a93722dc"
  late int createdAtSeconds;
  late DataAuthor author;
  late String content;
  late bool deleted;
  late List mediaURLs;

  Comment(Map<String, dynamic> data) {
    if (data.containsKey('comments')) {
      for (var e in (data['comments'] as List)) {
        Comment comment = Comment(e);
        comments.add(comment);
      }
    }
    id = data['id'];
    createdAtSeconds = data['created_at_seconds'];
    author = DataAuthor(data['author']);
    content = data['content'];
    deleted = data['deleted'];
    mediaURLs = data['media_urls'];
  }
}
