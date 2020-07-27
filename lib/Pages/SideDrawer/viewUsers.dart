import 'package:Lawyerito_Admin/Models/user.dart';
import 'package:Lawyerito_Admin/Widgets/userCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewUsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewUsersPageState();
  }
}

class ViewUsersPageState extends State<ViewUsersPage> {
  List<User> _users = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("Users"),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('user').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitChasingDots(
                  color: Colors.brown[400],
                );
              } else {
                _users = [];
                snapshot.data.documents.forEach((doc) {
                  User user = new User(
                    uid: doc.documentID,
                    email: doc['email'],
                    firstName: doc['firstName'],
                    lastName: doc['lastName'],
                    phoneNumber: doc['phoneNumber'],
                  );
                  _users.add(user);
                });
                return Container(
                      padding: EdgeInsets.all(10),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) =>
                            UserCard(_users[index]),
                        itemCount: _users.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(
                          height: 10,
                        ),
                      ),
                    );
              }
            }),
      ),
    );
  }
}
