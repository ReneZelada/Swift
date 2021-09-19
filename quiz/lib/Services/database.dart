
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz/Models/user.dart';





class DataBaseService{

  final String uid;
  DataBaseService( {required this.uid
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    User(uid:user.uid);

  }

}