import 'package:Lawyerito_Admin/Models/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User _user;

  UserCard(this._user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              this._user.firstName + ' ' + this._user.lastName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Email : ' + this._user.email,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Phone number : ' + this._user.phoneNumber,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
