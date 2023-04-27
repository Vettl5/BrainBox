//Notizenübersicht auf Homescreen
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class Notizen extends StatelessWidget {
  const Notizen({super.key});
  @override
  Widget build(BuildContext context) {                              //Zu jedem Widget gehört eine Build Funktion
    var appState = context.watch<MyAppState>();                     //Variable appState mit Klasse MyAppState linken
    //Directory appDocumentsDir = appState.appDocumentsDir;

    return ListView(                                        //eine Spalte, die man scrollen kann
      padding: EdgeInsets.all(16.0),                                // Innenabstand von 16 Pixeln auf allen Seiten
      shrinkWrap: true,                                             // Passt die Größe des Widgets an den Inhalt an
      physics: BouncingScrollPhysics(),                             // Ein physikalisches Scrollverhalten, das abprallt
      children: [
        
      ],
    );
  }
}*/