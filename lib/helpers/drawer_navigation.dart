import 'package:flutter/material.dart';
import 'package:todoey_sqflite/screens/categories_screen.dart';
import 'package:todoey_sqflite/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://tse2.mm.bing.net/th?id=OIP.ZP2bjbH53cd-XuhjizzssgHaKX&pid=Api&P=0&w=300&h=300'),
              ),
              accountName: Text('Bharat Arun'),
              accountEmail: Text('bharatarun032@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.view_list),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CatergoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
