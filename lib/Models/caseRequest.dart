import 'package:Lawyerito_Admin/Models/case.dart';
import 'package:Lawyerito_Admin/Models/lawyer.dart';

import 'user.dart';

class CaseRequest {
  final String requestID;
  final Lawyer lawyer;
  final Case requestedCase;
  final String state;

  CaseRequest({
    this.requestID,
    this.lawyer,
    this.requestedCase,
    this.state,
  });
}
