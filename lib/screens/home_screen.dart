import 'package:flutter/material.dart';
import 'package:todoey_sqflite/helpers/drawer_navigation.dart';
import 'package:todoey_sqflite/models/todo.dart';
import 'package:todoey_sqflite/screens/todo_screen.dart';
import 'package:todoey_sqflite/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;
  List<Todo> _todoList = List<Todo>();

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = List<Todo>();

    var todos = await _todoService.readTodos();
    todos.forEach((todo) {
      var model = Todo();
      model.id = todo['id'];
      model.title = todo['title'];
      model.description = todo['description'];
      model.category = todo['category'];
      model.todoDate = todo['todoDate'];
      model.isFinished = todo['isFinished'];
      _todoList.add(model);
    });
  }

  @override
  void initState() {
    getAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todoey Sqflite'),
        ),
        drawer: DrawerNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TodoScreen()));
          },
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_todoList[index].title ?? "No title"),
                    ],
                  ),
                  subtitle: Text(_todoList[index].category ?? "No Category"),
                  trailing: Text(_todoList[index].todoDate ?? 'No date'),
                ),
              ),
            );
          },
        ));
  }
}
