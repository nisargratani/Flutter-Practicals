import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'bookmarked_users.dart';
import 'tab1.dart';
import 'tab2.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox<BookmarkedData>("testBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookmarkedData>(
        create: (context) => BookmarkedData(),
        child: MaterialApp(
          home: HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          title: Text('User Details'),
          bottom: new TabBar(tabs: [
            new Tab(
              child: Text('Users'),
            ),
            new Tab(
              child: Text('Bookmarked'),
            )
          ], indicatorColor: Colors.teal),
        ),
        body: new TabBarView(
          children: [Tab1(), Tab2()],
        ),
      ),
    );
  }
}
