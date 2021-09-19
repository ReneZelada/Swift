import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz/Screens/Features.dart';
import 'package:quiz/Services/auth.dart';
import 'package:toast/toast.dart';


class Home extends StatefulWidget {

  @override

  _HomeState  createState()=> _HomeState();


}
class _HomeState  extends State<Home>{

  final AuthService  _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    return MaterialApp(

        home: Scaffold(

          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,

          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                  width:70,
                  child: RaisedButton(
                    onPressed: () => showAlertDialogPregunta(context),
                    child: Icon(Icons.add_box_outlined , color: Colors.white,),
                    color: Color.fromRGBO(8, 39, 66, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.all(const Radius.circular(100.0))),
                  ),)
              ],
            ),
          ),

          backgroundColor: Colors.white,
          appBar: AppBar(
           // title: Image.asset('assets/images/quinek.png', height: 20, width: 56,),
            backgroundColor: Color.fromRGBO(8, 39, 66, 1),
            elevation: 0.0,
            actions: <Widget>[

              FlatButton.icon(onPressed: () async {
                await _auth.signOut();
              }, icon: Icon(Icons.person), label: Text('logout'))
            ],

          ),
          body: Center(
            child: new Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    height: 300, child:  Features(),
                  ),
                ],
              ),
            ),
          )
        ),

    );
  }
  void showAlertDialogPregunta(BuildContext context) {

    String question = "";
    TextEditingController myController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Container(
              height: 230,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.white),
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Crear Pregunta', style: TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(height: 20,),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(25.0),
                            border: Border.all(
                              color: Colors.orange, //                   <--- border color
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Pregunta',
                                ),
                                validator: (val) => val!.isEmpty ? 'Enter some valid text' : null,
                                onChanged: (val){
                                  setState(() => question = val);
                                },
                              )))),
                  Container(
                    height: 40,
                    width: 200,
                    child: RaisedButton.icon(
                      color: Colors.orange,
                      icon: Icon(Icons.arrow_upward, color: Colors.white,),
                      label: Text("Enviar", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color:Colors.white)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),), onPressed: () async { print(question);
                    final DocumentReference documentReference=await Firestore.instance.collection("Questions").document("quiz").collection("Preguntas").add({

                      'ID':"",
                    });
                    final String ID = documentReference.documentID;
                    Firestore.instance.collection("Questions").document("quiz").collection("Preguntas").document(ID).setData({
                      'Pregunta': question,
                      'ID': ID,
                      'Tipo':"Pregunta",
                    }).then((value){
                      Toast.show("Agregada con exito", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    });

                      },
                    ),),

                ],
              ),
            )
        );
      },
    );
  }
}


