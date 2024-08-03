import 'package:pillcity/data_moudle/data_author.dart';
import 'package:pillcity/data_moudle/data_circles.dart';
import 'package:pillcity/data_moudle/data_comment.dart';
import 'package:pillcity/data_moudle/data_reaction.dart';
import 'package:pillcity/data_moudle/data_reshared.dart';

class DataPost {
  late String id; // "baeb70b1-a755-4b5c-857f-c7de754aa97a"
  late int createdAtSeconds; // 1634538819
  late DataAuthor author;
  late String content; // "快穿快穿"
  late bool isPublic;
  late bool reshareable;
  late DataReshared? resharedFrom; // 轉發
  late List mediaURLs;
  List<Reaction> reactions = <Reaction>[]; // emoji
  List<Comment> comments = <Comment>[]; // 可嵌套
  List<Circle> circles = <Circle>[]; // "id","name"
  late bool deleted;
  late bool isUpdateAvatar;

  DataPost(Map<String, dynamic> data) {
    id = data['id'];
    createdAtSeconds = data['created_at_seconds'];
    author = DataAuthor(data['author']);
    content = data['content'];
    isPublic = data['is_public'];
    reshareable = data['reshareable'];
    resharedFrom = data['reshared_from'] != null
        ? DataReshared(data['reshared_from'])
        : null;
    mediaURLs = data['media_urls'];
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
    isUpdateAvatar = data['is_update_avatar'];
  }
}
