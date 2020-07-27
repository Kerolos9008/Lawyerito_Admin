import 'package:Lawyerito_Admin/Models/case.dart';
import 'package:flutter/material.dart';

class CaseCard extends StatefulWidget {
  final Case _case;

  CaseCard(this._case);

  @override
  _CaseCardState createState() => _CaseCardState();
}

class _CaseCardState extends State<CaseCard> {
  Color stateColor;

  @override
  Widget build(BuildContext context) {
    if (this.widget._case.state.compareTo("in Progress") == 0) {
      stateColor = Colors.black38;
    } else if (this.widget._case.state.compareTo("Won") == 0) {
      stateColor = Colors.green;
    } else {
      stateColor = Colors.red;
    }
    print(this.widget._case.owner);
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  this.widget._case.caseNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(" for "),
                Text(
                  this.widget._case.year,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5, top: 5, left: 20),
              child: Text(
                "Case of" + this.widget._case.caseType,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
            ),
            Text("Owneb by: " +
                this.widget._case.owner.firstName +
                " " +
                this.widget._case.owner.lastName),
            SizedBox(
              height: 10,
            ),
            this.widget._case.assigned
                ? Text(
                    "Assigned to: " +
                        this.widget._case.assignedLawyer.firstName +
                        " " +
                        this.widget._case.assignedLawyer.lastName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : Text(
                    "Not Assigned yet",
                    style: TextStyle(color: Colors.black38),
                  ),
            SizedBox(
              height: 10,
            ),
            Text(
              this.widget._case.information,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 12),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 10),
              child: Text(
                this.widget._case.state,
                style: TextStyle(
                    fontSize: 14,
                    color: stateColor,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
