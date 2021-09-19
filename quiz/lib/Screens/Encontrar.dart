
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class Encontrar extends StatefulWidget {
  String text;

  Encontrar({required this.text,});
  @override

  _EncontrarState  createState()=> _EncontrarState();


}
class _EncontrarState  extends State<Encontrar>{

  late String question;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Color.fromRGBO(8, 39, 66, 1),
        elevation: 0.0,
        actions: <Widget>[

        ],
      ),

      body: Center(
      child: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Questions").document("quiz").collection("Preguntas").where("ID", isEqualTo: widget.text).snapshots(),
              builder: (context, snapshot){
              if(!snapshot.hasData) return Text('loading');

                return Column(
                children: [
                Text(snapshot.data!.documents[0]['Pregunta'], style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.w700),),
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
                                validator: (val) => val!.isEmpty ? 'No la puede dejar en blanco' : null,
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
                    Firestore.instance.collection("Answers").document("quiz").collection("Respuestas").document(ID).setData({
                      'ID Question': widget.text,
                      'ID': ID,
                      'Respuesta':question,
                    }).then((value){
                      Toast.show("Agregada con exito", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    });

                    },
                    ),),

                ],
                );}),

    ));
  }
}
