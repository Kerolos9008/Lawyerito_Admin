import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:Lawyerito_Admin/Pages/SideDrawer/viewCases.dart';
import 'package:Lawyerito_Admin/Pages/SideDrawer/viewFeedbacks.dart';
import 'package:Lawyerito_Admin/Pages/SideDrawer/viewLawyers.dart';
import 'package:Lawyerito_Admin/Pages/SideDrawer/viewRequests.dart';
import 'package:Lawyerito_Admin/Pages/SideDrawer/viewUsers.dart';
import 'package:Lawyerito_Admin/Pages/adminLogin.dart';
import 'package:Lawyerito_Admin/Pages/lawyerPage.dart';
import 'package:Lawyerito_Admin/Services/adminAuth.dart';
import 'package:Lawyerito_Admin/Widgets/lawyerCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminHomePageState();
  }
}

class AdminHomePageState extends State<AdminHomePage> {
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
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(
                Icons.adjust,
              ),
              title: Text('View users'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewUsersPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.adjust,
              ),
              title: Text('View lawyers'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewLawyersPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.adjust,
              ),
              title: Text('View cases'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewCasesPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.adjust,
              ),
              title: Text('View Feedbacks'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewFeedbacksPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.adjust,
              ),
              title: Text('View requests'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewRequestsPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text('Log out'),
              onTap: () async {
                await _authService.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AdminLoginPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text("Lawyerito"),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('lawyer').where('confirmed', isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitChasingDots(
              color: Colors.brown[400],
            );
          } else {
            _lawyersList = [];
            snapshot.data.documents.forEach((doc) {
              Lawyer lawyer = new Lawyer(
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
              print("lawyer:" + lawyer.toString());
              _lawyersList.add(lawyer);
            });
            print("length = " + _lawyersList.length.toString());
            return Container(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LawyerPage(_lawyersList[index])));
                  },
                  child: LawyerCard(_lawyersList[index]),
                ),
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
