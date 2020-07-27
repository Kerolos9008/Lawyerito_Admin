import 'package:Lawyerito_Admin/Models/case.dart';
import 'package:Lawyerito_Admin/Models/caseRequest.dart';
import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:Lawyerito_Admin/Models/user.dart';
import 'package:Lawyerito_Admin/Widgets/requestCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ViewRequestsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewRequestsPageState();
  }
}

class ViewRequestsPageState extends State<ViewRequestsPage> {
  List<CaseRequest> _requests = [];
  bool loading = true;
  List<Lawyer> _lawyers = [];
  List<Case> _cases = [];

  @override
  void initState() {
    _lawyers = [];
    _cases = [];
    // TODO: implement initState
    Firestore.instance.collection('lawyer').getDocuments().then((lawyers) {
      Firestore.instance.collection('case').getDocuments().then((cases) {
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
        cases.documents.forEach((doc) {
          Case _case = Case(
            caseId: doc.documentID,
            assigned: doc['assigned'],
            assignedLawyer: null,
            caseNumber: doc['caseNumber'],
            caseType: doc['caseType'],
            information: doc['information'],
            owner: User(uid: doc['owner']),
            state: doc['state'],
            year: doc['year'],
          );
          _cases.add(_case);
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
          title: Text("Requests"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('request')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || loading) {
              return SpinKitChasingDots(
                color: Colors.brown[400],
              );
            } else {
              _requests = [];
              snapshot.data.documents.forEach((doc) {
                Lawyer _lawyer;
                Case _case;
                _lawyers.forEach((element) {
                  if (element.lawyerId == doc['lawyer']) {
                    _lawyer = element;
                  }
                });
                _cases.forEach((element) {
                  if (element.caseId == doc['case']) {
                    _case = element;
                  }
                });
                CaseRequest _request = CaseRequest(
                  requestID: doc.documentID,
                  requestedCase: _case,
                  state: doc['state'],
                  lawyer: _lawyer,
                );
                _requests.add(_request);
              });
              return (_requests.length != 0)
                  ? Container(
                      padding: EdgeInsets.all(10),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) =>
                            RequestCard(_requests[index]),
                        itemCount: _requests.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(
                          height: 10,
                        ),
                      ),
                    )
                  : Container(
                      child: Text(
                        "No recent Requests.",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      alignment: Alignment.center,
                    );
            }
          },
        ),
      ),
    );
  }
}
