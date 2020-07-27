import 'dart:convert';
import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:Lawyerito_Admin/Services/adminData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LawyerPage extends StatelessWidget {
  Lawyer _lawyer;
  AdminDataService _adminDataService = AdminDataService();
  LawyerPage(this._lawyer);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lawyer Details'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Image.memory(
                      base64.decode(this._lawyer.image),
                      width: MediaQuery.of(context).size.width * 2 / 7,
                      height: MediaQuery.of(context).size.width * 2 / 7,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          this._lawyer.firstName + " " + this._lawyer.lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Since ",
                              style: TextStyle(color: Colors.black45),
                            ),
                            Text(
                              this._lawyer.since,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Office Address : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this._lawyer.officeAddress,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Email: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this._lawyer.email,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Phone number : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this._lawyer.phoneNumber,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await _adminDataService.confirmLawyer(this._lawyer.lawyerId);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
