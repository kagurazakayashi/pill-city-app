import 'package:pillcity/data_moudle/data_author.dart';

class Reaction {
  late String id; // "47a3a192-06a2-477d-b6fd-b708a2730a0f"
  late String emoji; // "🧦"
  late DataAuthor author;

  Reaction(Map<String, dynamic> data) {
    id = data['id'];
    emoji = data['emoji'];
    author = DataAuthor(data['author']);
  }
}
