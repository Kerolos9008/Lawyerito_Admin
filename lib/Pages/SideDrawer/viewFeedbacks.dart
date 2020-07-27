import 'package:Lawyerito_Admin/Models/case.dart';
import 'package:Lawyerito_Admin/Models/caseFeedback.dart';
import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:Lawyerito_Admin/Models/user.dart';
import 'package:Lawyerito_Admin/Widgets/feedbackCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ViewFeedbacksPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewFeedbacksPageState();
  }
}

class ViewFeedbacksPageState extends State<ViewFeedbacksPage> {
  List<CaseFeedback> _feedbacks = [];
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
          cases.documents.forEach((docCase) {
            if (_lawyer.lawyerId == docCase['assignedLawyer']) {
              Case _case = Case(
                caseId: docCase.documentID,
                assigned: docCase['assigned'],
                assignedLawyer: _lawyer,
                caseNumber: docCase['caseNumber'],
                caseType: docCase['caseType'],
                information: docCase['information'],
                owner: User(uid: docCase['owner']),
                state: docCase['state'],
                year: docCase['year'],
              );
              _cases.add(_case);
            }
          });
          _lawyers.add(_lawyer);
        });
        cases.documents.forEach((doc) {
          if (doc['assigned'] == false) {
            Case _case = Case(
              caseId: doc.documentID,
              assigned: doc['assigned'],
              assignedLawyer: doc['assignedLawyer'],
              caseNumber: doc['caseNumber'],
              caseType: doc['caseType'],
              information: doc['information'],
              owner: User(uid: doc['owner']),
              state: doc['state'],
              year: doc['year'],
            );
            _cases.add(_case);
          }
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
          title: Text("Feedbacks"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('feedback')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || loading) {
              return SpinKitChasingDots(
                color: Colors.brown[400],
              );
            } else {
              _feedbacks = [];
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
                CaseFeedback _feedback = CaseFeedback(
                  feedback: doc['feedback'],
                  feedbackCase: _case,
                  lawyer: _lawyer,
                );
                _feedbacks.add(_feedback);
              });
              return Container(
                padding: EdgeInsets.all(10),
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>
                      FeedbackCard(_feedbacks[index]),
                  itemCount: _feedbacks.length,
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
