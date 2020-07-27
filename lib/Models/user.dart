import 'dart:convert';

class User {

  final String uid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;

  User({ this.uid,this.firstName,this.lastName, this.email, this.phoneNumber });

  Map toJson() => {
        'uid' : uid,
        'firstName': firstName,
        'lastName' : lastName,
        'email' : email,
        'phoneNumber' : phoneNumber
      };
  
  String toString() => jsonEncode(this.toJson());
}