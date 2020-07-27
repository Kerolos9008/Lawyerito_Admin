import 'package:Lawyerito_Admin/Models/lawyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user.dart';

class AdminDataService {
  final CollectionReference userCollection =
      Firestore.instance.collection('user');
  final CollectionReference lawyerCollection =
      Firestore.instance.collection('lawyer');
  final CollectionReference caseCollection =
      Firestore.instance.collection('case');
  final CollectionReference requestCollection =
      Firestore.instance.collection('request');

  List<Lawyer> getLawyers() {
    List<Lawyer> lawyers = [];
    lawyerCollection.snapshots().listen((data) {
      data.documents.forEach((doc) {
        Lawyer lawyer = new Lawyer(
          email: doc['email'],
          firstName: doc['firstName'],
          lastName: doc['lastName'],
          image: doc['image'],
          officeAddress: doc['officeAddress'],
          phoneNumber: doc['phoneNumber'],
        );
        print("lawyer:" + lawyer.toString());
        lawyers.add(lawyer);
      });
    });
    print("length = " + lawyers.length.toString());
    return lawyers;
  }

  Future<void> confirmLawyer(String lawyerId) {
    return lawyerCollection.document(lawyerId).updateData({
      'confirmed': true,
    });
  }
}
