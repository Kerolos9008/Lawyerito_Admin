import 'package:Lawyerito_Admin/Pages/adminLogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/user.dart';
import 'Services/adminAuth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AdminAuthService().user,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.brown[400],
          accentColor: Colors.pink,
        ),
        home: AdminLoginPage(),
      ),
    );
  }
}
