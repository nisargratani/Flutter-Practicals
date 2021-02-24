class Todo {
  int id;
  String title;
  String category;
  String description;
  String todoDate;
  int isFinished;

  todoMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['category'] = category;
    mapping['todoDate'] = todoDate;
    mapping['isFinished'] = isFinished;
    mapping['description'] = description;
    return mapping;
  }
}
