import 'package:Lawyerito_Admin/Models/caseRequest.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final CaseRequest _request;
  Color stateColor;
  RequestCard(this._request);
  @override
  Widget build(BuildContext context) {
    if (this._request.state.compareTo("Pending") == 0) {
      stateColor = Colors.black38;
    } else if (this._request.state.compareTo("Accepted") == 0) {
      stateColor = Colors.green;
    } else {
      stateColor = Colors.red;
    }
    // TODO: implement build
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Request for Case " +
                            this._request.requestedCase.caseNumber,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(" for "),
                      Text(
                        this._request.requestedCase.year,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "From : ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        this._request.lawyer.firstName +
                            " " +
                            this._request.lawyer.lastName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: stateColor,
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Text(
                this._request.state,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
