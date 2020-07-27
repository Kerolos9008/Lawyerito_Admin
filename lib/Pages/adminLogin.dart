import './adminHome.dart';
import '../Services/adminAuth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminLoginPageState();
  }
}

class AdminLoginPageState extends State<AdminLoginPage> {
  final AdminAuthService _auth = AdminAuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Admin Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Username",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'username' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0),
                  ),
                ),
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              Container(
                height: 35,
                width: 90,
                child: RaisedButton(
                  color: Colors.pink[400],
                  child: loading
                      ? SpinKitChasingDots(
                          color: Colors.brown,
                          size: 14.0,
                        )
                      : Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = _auth.signInWithEmailAndPassword(
                          email, password);
                      setState(() {
                        loading = false;
                      });
                      if (result == false) {
                        setState(() {
                          error = 'Wrong username or password';
                        });
                      } else {
                        error = '';
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminHomePage()));
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
