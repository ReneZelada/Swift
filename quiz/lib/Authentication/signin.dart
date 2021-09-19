
import 'package:flutter/material.dart';
import 'package:quiz/Authentication/PasswordReset.dart';
import 'package:quiz/Home/Home.dart';
import 'package:quiz/Screens/Encontrar.dart';
import 'package:quiz/Services/auth.dart';



import 'PasswordReset.dart';


class SignIn extends StatefulWidget {

  @override

  _SignInState  createState()=> _SignInState();


}

class _SignInState  extends State<SignIn>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String password ='';
  String error ='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 39, 66, 1),
        elevation: 0.0,
        title: Text('Iniciar sesion'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 70.0),
              Text("Inicio",style: TextStyle(color: Color.fromRGBO(8, 39, 66, 1), fontSize: 45.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email',),
                  validator: (val) => val!.isEmpty ? 'Ingresa un email valido' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),

              Container(
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Password',),
                  validator: (val) => val!.length < 6 ? 'Ingresa un password mayor de 6 digitos' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
              ),
              FlatButton.icon(onPressed:() {Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PasswordReset(),
                  ));}, icon: Icon(Icons.lock,color: Colors.blueGrey), label: Text("olvidaste tu contraseña",style: TextStyle(color: Colors.blueGrey, fontSize: 15.0,))),

              SizedBox(height: 90.0),
              Container(
                height: 50,
                width: 400,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33.0),
                      side: BorderSide(color: Color.fromRGBO(8, 39, 66, 1))),
                  color: Colors.white,
                  elevation: 1.0,
                  child: Text(
                    'Iniciar',
                    style: TextStyle(color: Color.fromRGBO(8, 39, 66, 1), fontSize: 20),
                  ),
                  onPressed: () async{
                    print(email);
                    if(_formKey.currentState!.validate()){
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(()  => error = 'verifica tus credenciales');
                      }else{
                        print(result);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                             builder: (context) => Home(),

                            ));
                      }
                    }
                  },
                ),),
              SizedBox(height: 12.0),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                child: TextFormField(
                  onFieldSubmitted: (val){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Encontrar(text: val,),
                        ));
                  },
                  keyboardType: TextInputType.visiblePassword,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    contentPadding: EdgeInsets.all(20.0),
                    filled: true,
                    fillColor: Colors.white30,
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.white30)),
                  ),

                ),),
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