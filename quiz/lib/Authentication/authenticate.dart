
import 'package:flutter/material.dart';
import 'package:quiz/Authentication/signin.dart';

class Authenticate extends StatefulWidget{

  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(showSignIn == true){
      return SignIn();
    }
    else{
      return SignIn();
    }
  }
}