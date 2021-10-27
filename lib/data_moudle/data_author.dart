class DataAuthor {
  String id = ""; // "yashi"
  int created_at_seconds = -1; // 1632125699
  String avatar_url =
      ""; // "https://pill-city.s3.us-west-2.amazonaws.com/avatars/yashi-1632125933.png"
  String profile_pic = ""; // "pill4.png"
  String display_name = ""; // "史詩級巨大 KT"

  DataAuthor(Map<String, dynamic> data) {
    id = data['id'];
    created_at_seconds = data['created_at_seconds'].toInt();
    avatar_url = data['avatar_url'];
    profile_pic = data['profile_pic'];
    display_name = data['display_name'] ?? id;
  }
}
