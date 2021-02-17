import 'package:flutter/material.dart';
import 'bookmarked_users.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  Box<BookmarkedData> testBox;
  @override
  void initState() {
    // TODO: implement initState
    testBox = Hive.box<BookmarkedData>("testBox");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<BookmarkedData>(
        builder: (context, userData, child) => ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              leading: CircleAvatar(
                  radius: 35.0,
                  child: Image(
                      image:
                          NetworkImage('${userData.users[index].avatarUrl}'))),
              title: Text('${userData.users[index].loginName}'),
              trailing: Checkbox(
                value: true,
                onChanged: (newValue) {
                  if (newValue == false) {
                    userData.remove(userData.users[index]);
                    testBox.delete(userData);
                  }
                },
              ),
            );
          },
          itemCount: userData.users.length,
        ),
      ),
    );
  }
}
