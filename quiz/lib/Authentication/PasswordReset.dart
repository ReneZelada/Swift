
import 'package:flutter/material.dart';
import 'package:quiz/Services/auth.dart';
import 'package:toast/toast.dart';


class PasswordReset extends StatefulWidget {
  @override

  _PasswordResetState  createState()=> _PasswordResetState ();


}

class _PasswordResetState  extends State<PasswordReset>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String error ='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 39, 66, 1),
        elevation: 0.0,
        title: Text('Restablecer',style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          //   FlatButton.icon(onPressed: () {widget.toggleView();} , icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 70.0),
              Text("Restablecer",style: TextStyle(color: Color.fromRGBO(8, 39, 66, 1), fontSize: 40.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email',),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 50,
                width: 400,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33.0),
                      side: BorderSide(color: Color.fromRGBO(8, 39, 66, 1))),
                  color: Colors.white,
                  child: Text(
                    'Enviar',
                    style: TextStyle(color: Color.fromRGBO(8, 39, 66, 1)),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      await _auth.resetPassword(email);
                      Toast.show("we sent you an email please check your inbox", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                    }
                  },
                ),),
              //  FlatButton.icon(onPressed:() {}, icon: Icon(Icons.lock), label: Text("Olvide mi password",style: TextStyle(color: Colors.red[400], fontSize: 15.0, fontWeight: FontWeight.bold))),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

            ],
          ),
        ),

      ),

    );
  }

}
