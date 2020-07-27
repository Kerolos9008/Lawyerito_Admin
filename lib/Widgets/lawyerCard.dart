import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

class LawyerCard extends StatelessWidget {
  final Lawyer _lawyer;
  final Base64Codec base64 = Base64Codec();
  LawyerCard(this._lawyer);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.memory(
                  base64.decode(this._lawyer.image),
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
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
                      height: 8,
                    ),
                    Text(
                      "At " + this._lawyer.officeAddress,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
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
        ),
      ),
    );
  }
}
