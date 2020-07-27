import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:Lawyerito_Admin/Pages/adminLogin.dart';
import 'package:Lawyerito_Admin/Services/adminAuth.dart';
import 'package:Lawyerito_Admin/Widgets/lawyerCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewLawyersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewLawyersPageState();
  }
}

class ViewLawyersPageState extends State<ViewLawyersPage> {
  List<Lawyer> _lawyersList = [];
  AdminAuthService _authService = AdminAuthService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // UserDataService _userDataService =
    //     UserDataService(Provider.of<User>(context).uid);
    // this._lawyersList = _userDataService.getLawyers();
    return Scaffold(
      backgroundColor: Colors.brown[100],
      
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text("Lawyers"),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('lawyer').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitChasingDots(
              color: Colors.brown[400],
            );
          } else {
            _lawyersList = [];
            snapshot.data.documents.forEach((doc) {
              Lawyer lawyer = new Lawyer(
                email: doc['email'],
                firstName: doc['firstName'],
                lastName: doc['lastName'],
                image: doc['image'],
                officeAddress: doc['officeAddress'],
                phoneNumber: doc['phoneNumber'],
                since: doc['since'],
                nationalId: doc['nationalId'],
              );
              print("lawyer:" + lawyer.toString());
              _lawyersList.add(lawyer);
            });
            print("length = " + _lawyersList.length.toString());
            return Container(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    LawyerCard(_lawyersList[index]),
                itemCount: _lawyersList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  height: 5,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
