import 'package:flutter/material.dart';
import 'package:todoey_sqflite/models/todo.dart';
import 'package:todoey_sqflite/services/todo_service.dart';

class TodosByCategory extends StatefulWidget {
  TodosByCategory({this.category});
  final String category;
  @override
  _TodosByCategoryState createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todoList = List<Todo>();
  TodoService _todoService = TodoService();

  getTodosByCategories() async {
    var todos = await _todoService.readTodosByCategory(this.widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];
        _todoList.add(model);
      });
    });
  }

  @override
  void initState() {
    getTodosByCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.category),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 8.0,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[Text(_todoList[index].title)],
                      ),
                      subtitle: Text(_todoList[index].description),
                      trailing: Text(_todoList[index].todoDate),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
