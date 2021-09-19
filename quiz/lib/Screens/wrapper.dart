
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quiz/Authentication/signin.dart';
import 'package:quiz/Home/Home.dart';
import 'package:quiz/Models/user.dart';




class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null || user.uid == ""){
      return SignIn();
    }else{
      return Home();
    }
  }
}