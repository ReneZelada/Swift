import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class Features extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String Name;
    // TODO: implement build
    return StreamBuilder(
      stream: Firestore.instance.collection("Questions").document("quiz").collection("Preguntas").where("Tipo", isEqualTo: "Pregunta").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('No hay resultados..',style: GoogleFonts.roboto(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold));
        return new ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(0.0),//check on right and left only
          shrinkWrap: true,
          children: snapshot.data!.documents.map((document) {
            return new Column(
              children: [
             Center(
            child: Text("Pregunta: " + document['Pregunta'],
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),),
                Center(
                  child: Text("Codigo de ingreso: " + document['ID'],
                    style: GoogleFonts.roboto(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),),
              ],
            );

           /*return new Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 45,
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.black,
                          // color: Color.fromRGBO(159, 159, 159, 0.50),//Color(0xff0F0F0F),
                        ),
                        child: Center(
                          child: Text( document['Pregunta'],
                            style: GoogleFonts.roboto(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),

                        ),
                      ),),

                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33.0)
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),

              //title: new Text(document['Nombre']),
            );*/
          }).toList(),
        );
      },
    );

  }

}