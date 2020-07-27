import 'dart:convert';

class Lawyer {
  final String lawyerId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String officeAddress;
  String nationalId;
  String image;
  String since;

  Lawyer(
      {this.lawyerId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.officeAddress,
      this.nationalId,
      this.image,
      this.since});

  Map toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber
      };

  String toString() => jsonEncode(this.toJson());
}
