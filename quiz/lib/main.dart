
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/Models/user.dart';
import 'package:quiz/Screens/wrapper.dart';
import 'package:quiz/Services/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: User(uid: ""),
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
