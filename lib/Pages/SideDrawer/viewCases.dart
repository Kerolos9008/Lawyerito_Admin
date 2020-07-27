import 'package:Lawyerito_Admin/Models/case.dart';
import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:Lawyerito_Admin/Models/user.dart';
import 'package:Lawyerito_Admin/Widgets/caseCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ViewCasesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewCasesPageState();
  }
}

class ViewCasesPageState extends State<ViewCasesPage> {
  List<Case> _casesList = [];
  List<User> _users = [];
  List<Lawyer> _lawyers = [];
  bool loading = true;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    _lawyers = [];
    _users = [];

    // TODO: implement initState
    Firestore.instance.collection('lawyer').getDocuments().then((lawyers) {
      Firestore.instance.collection('user').getDocuments().then((users) {
        users.documents.forEach((doc) {
          User user = new User(
            uid: doc.documentID,
            email: doc['email'],
            firstName: doc['firstName'],
            lastName: doc['lastName'],
            phoneNumber: doc['phoneNumber'],
          );
          _users.add(user);
        });
        lawyers.documents.forEach((doc) {
          Lawyer _lawyer = Lawyer(
            lawyerId: doc.documentID,
            email: doc['email'],
            firstName: doc['firstName'],
            lastName: doc['lastName'],
            image: doc['image'],
            officeAddress: doc['officeAddress'],
            phoneNumber: doc['phoneNumber'],
            since: doc['since'],
            nationalId: doc['nationalId'],
          );
          _lawyers.add(_lawyer);
        });
        setState(() {
          loading = false;
        });
      });
    });

    super.initState();
  }

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
          title: Text("Cases"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('case').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || loading) {
              return SpinKitChasingDots(
                color: Colors.brown[400],
              );
            } else {
              this._casesList = [];
              snapshot.data.documents.forEach((doc) {
                _users.forEach((user) {
                  if (user.uid == doc['owner']) {
                    if (doc['assigned'] == true) {
                      _lawyers.forEach((element) {
                        if (element.lawyerId == doc['assignedLawyer']) {
                          Case _case = new Case(
                            assigned: doc['assigned'],
                            assignedLawyer: element,
                            caseNumber: doc['caseNumber'],
                            caseType: doc['caseType'],
                            information: doc['information'],
                            owner: user,
                            state: doc['state'],
                            year: doc['year'],
                          );
                          this._casesList.add(_case);
                        }
                      });
                    } else {
                      Case _case = new Case(
                        assigned: doc['assigned'],
                        assignedLawyer: doc['assignedLawyer'],
                        caseNumber: doc['caseNumber'],
                        caseType: doc['caseType'],
                        information: doc['information'],
                        owner: user,
                        state: doc['state'],
                        year: doc['year'],
                      );
                      this._casesList.add(_case);
                    }
                  }
                });
              });
              return Container(
                padding: EdgeInsets.all(10),
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>
                      CaseCard(_casesList[index]),
                  itemCount: _casesList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 10,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
