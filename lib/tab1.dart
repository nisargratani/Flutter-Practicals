import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'loading_screen.dart';
import 'package:provider/provider.dart';
import 'bookmarked_users.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (Provider.of<BookmarkedData>(context).allUsers.length != 0)
            ? DataList()
            : Loading());
  }
}

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  Box testBox;
  @override
  void initState() {
    // TODO: implement initState
    testBox = Hive.box<BookmarkedData>("testBox");
    BookmarkedData bookmarkedData = BookmarkedData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<BookmarkedData>(
        builder: (context, userData, child) => ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 35.0,
                child: Image(
                  image: NetworkImage('${userData.allUsers[index].avatarUrl}'),
                ),
              ),
              title: Text('${userData.allUsers[index].loginName}'),
              trailing: Checkbox(
                  value: userData.allUsers[index].isChecked,
                  onChanged: (newValue) {
                    if (newValue == true) {
                      userData.add(userData.allUsers[index]);
                      final user = Hive.box("testBox");
                      user.add(userData);
                    }
                    if (newValue == false) {
                      userData.remove(userData.allUsers[index]);
                    }
                    userData.allUsers[index].isChecked = newValue;
                  }),
            );
          },
          itemCount: userData.allUsers.length,
        ),
      ),
    );
  }
}
