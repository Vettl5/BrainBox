//Notizenübersicht auf Homescreen

import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'main.dart';
import 'notizen_bearbeiten.dart';

/*----------------------------------------------------------------------------------------------*/

class Notizen extends StatefulWidget {
  const Notizen({super.key});
  @override
  State<Notizen> createState() => _NotizenState();
}



class _NotizenState extends State<Notizen> {
  late final MyAppState appState;

  @override
  void initState() {
    super.initState();
    appState = MyAppState();
  }

  @override
  Widget build(BuildContext context) {   
    return buildNotizenListe();                                     
  }

  Widget buildNotizenListe() {
    if (appState.notizen.isEmpty) {
      return Text('Du hast noch keine Notizen erstellt.');
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: appState.notizen.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appState.notizen[index]),
            onTap: () {
              openAndEditFile(context, File(appState.notizen[index]));
            },
          );
        },
      );
    }
  }
}

  /*Widget build(BuildContext context) {                              //Zu jedem Widget gehört eine Build Funktion    
    return ListView(                                                //eine Spalte, die man scrollen kann
      padding: EdgeInsets.all(16.0),                                // Innenabstand von 16 Pixeln auf allen Seiten
      shrinkWrap: true,                                             // Passt die Größe des Widgets an den Inhalt an
      physics: BouncingScrollPhysics(),                             // Ein physikalisches Scrollverhalten, das abprallt
      children: [
        if (appState.notizen.isEmpty)                            
          Text('Du hast noch keine Notizen erstellt.');
        else
          for (var notiz in appState.notizen)                         // Für jede Notiz in der Liste notizen wird ein ListTile erstellt
            ListTile(
              title: Text(notiz),                                     // Der Titel des ListTiles ist der Name der Notiz
              onTap: () {
                openAndEditFile(context, File(notiz));
                //Navigator.pushNamed(context, '/bearbeiten', arguments: {'file': File(notiz)});
              },
            ),
        
      ],
    );
  }*/
