import 'package:Lawyerito_Admin/Models/caseFeedback.dart';
import 'package:Lawyerito_Admin/Pages/feedbackPage.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  final CaseFeedback _feedback;

  FeedbackCard(this._feedback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FeedbackPage(this._feedback)));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "ON Case " + this._feedback.feedbackCase.caseNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(" for "),
                  Text(
                    this._feedback.feedbackCase.year,
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
                children: <Widget>[
                  Text(
                    "From : ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    this._feedback.lawyer.firstName +
                        " " +
                        this._feedback.lawyer.lastName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Feedback : ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      this._feedback.feedback,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
