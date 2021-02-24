import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoey_sqflite/models/todo.dart';
import 'package:todoey_sqflite/services/category_service.dart';
import 'package:todoey_sqflite/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();

  var _todoDescriptionController = TextEditingController();

  var _todoDateController = TextEditingController();

  var _selectedValue;

  var _categories = List<DropdownMenuItem>();

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
    print(_categories);
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text = DateFormat('yyyy-mm-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _todoTitleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Write Todo title',
                ),
              ),
              TextField(
                controller: _todoDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Write Todo description',
                ),
              ),
              TextField(
                controller: _todoDateController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Write Todo title',
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              DropdownButtonFormField(
                value: _selectedValue,
                hint: Text('Category'),
                items: _categories,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  var todoObject = Todo();
                  todoObject.title = _todoTitleController.text;
                  todoObject.description = _todoDescriptionController.text;
                  todoObject.isFinished = 0;
                  todoObject.category = _selectedValue.toString();
                  todoObject.todoDate = _todoDateController.text;

                  var _todoService = TodoService();
                  var result = await _todoService.saveTodo(todoObject);
                  print(result);
                },
                color: Colors.blue,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
