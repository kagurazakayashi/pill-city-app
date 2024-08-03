class DataAuthor {
  String id = ""; // "yashi"
  int createdAtSeconds = -1; // 1632125699
  String avatarURL =
      ""; // "https://pill-city.s3.us-west-2.amazonaws.com/avatars/yashi-1632125933.png"
  String profilePic = ""; // "pill4.png"
  String displayName = ""; // "史詩級巨大 KT"

  DataAuthor(Map<String, dynamic> data) {
    id = data['id'];
    createdAtSeconds = data['created_at_seconds'].toInt();
    avatarURL = data['avatar_url'] ?? '';
    profilePic = data['profile_pic'];
    displayName = data['display_name'] ?? id;
  }
}
