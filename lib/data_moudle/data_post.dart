import 'package:pill_city/data_moudle/data_author.dart';
import 'package:pill_city/data_moudle/data_circles.dart';
import 'package:pill_city/data_moudle/data_comment.dart';
import 'package:pill_city/data_moudle/data_reaction.dart';
import 'package:pill_city/data_moudle/data_reshared.dart';

class DataPost {
  late String id; // "baeb70b1-a755-4b5c-857f-c7de754aa97a"
  late int created_at_seconds; // 1634538819
  late DataAuthor author;
  late String content; // "快穿快穿"
  late bool is_public;
  late bool reshareable;
  late DataReshared? reshared_from; // 轉發
  late List media_urls;
  List<Reaction> reactions = <Reaction>[]; // emoji
  List<Comment> comments = <Comment>[]; // 可嵌套
  List<Circle> circles = <Circle>[]; // "id","name"
  late bool deleted;
  late bool is_update_avatar;

  DataPost(Map<String, dynamic> data) {
    id = data['id'];
    created_at_seconds = data['created_at_seconds'];
    author = DataAuthor(data['author']);
    content = data['content'];
    is_public = data['is_public'];
    reshareable = data['reshareable'];
    reshared_from = data['reshared_from'] != null
        ? DataReshared(data['reshared_from'])
        : null;
    media_urls = data['media_urls'];
    for (var e in (data['reactions'] as List)) {
      Reaction reaction = Reaction(e);
      reactions.add(reaction);
    }
    for (var e in (data['comments'] as List)) {
      Comment comment = Comment(e);
      comments.add(comment);
    }
    for (var e in (data['circles'] as List)) {
      Circle circle = Circle(e);
      circles.add(circle);
    }
    deleted = data['deleted'];
    is_update_avatar = data['is_update_avatar'];
  }
}
