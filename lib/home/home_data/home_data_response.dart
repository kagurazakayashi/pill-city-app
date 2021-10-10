import 'dart:convert';

import 'package:pill_city/data_moudle/data_post.dart';

class HomeDataResponse {
  List<DataPost> posts = <DataPost>[];

  HomeDataResponse(dynamic response) {
    // print('response:');
    // print(response.length);
    // print(response[0]);
    List jsonResponse = response;
    // // print('jsonResponse:');
    // // print(jsonResponse);
    // // print(jsonResponse[0]);
    // // print(jsonResponse[0]);
    for (var e in jsonResponse) {
      // print(e);
      DataPost post = DataPost(e);
      posts.add(post);
    }
    // jsonResponse.map((e){
    //   print(' ==== ');
    //   print(e);
    //   DataPost post = DataPost(e);
    //   posts.add(post);
    // });
    print('posts:');
    print(posts);
  }
}
