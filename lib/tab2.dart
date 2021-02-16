import 'package:flutter/material.dart';
import 'bookmarked_users.dart';
import 'package:provider/provider.dart';

class Tab2 extends StatelessWidget {
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
