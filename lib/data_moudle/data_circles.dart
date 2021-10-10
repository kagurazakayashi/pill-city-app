class Circle {
  late String id; // "3d332e08-1138-4a77-b847-c3439139f949"
  late String name; // "G+"

  Circle(Map<String,dynamic> data) {
    id = data['id'];
    name = data['name'];
  }
}