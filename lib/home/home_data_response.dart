import 'dart:convert';

import 'package:pillcity/data_moudle/data_post.dart';

class HomeDataResponse {
  List<DataPost> posts = <DataPost>[];

  HomeDataResponse(String response) {
    List jsonResponse = jsonDecode(response);
    for (var e in jsonResponse) {
      DataPost post = DataPost(e);
      posts.add(post);
    }
  }
}
