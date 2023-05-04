import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'notizen_uebersicht.dart';
import 'widget_appbar.dart';

/*----------------------------------NOTIZEN WIDGET GENERATOR-------------------------------------*/

class NotizenListe extends StatefulWidget {
  const NotizenListe({super.key});
  @override
  State<NotizenListe> createState() => _NotizenListeState();
}

class _NotizenListeState extends State<NotizenListe> {
  bool _isDeleting = false;                                  //Checkboxen State (angetickt oder nicht)
  
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return buildNotizenListe(appState);                                     
  }

  Widget buildNotizenListe(MyAppState appState) {
    List<String> notizenname = appState.notizenname;

    /*--------------------------------------------------------Color setter für Checkboxen-----------------------------------------------------------*/
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    Widget NotizenListe = notizenname.isEmpty == true
        ? Center(
            child: Text('Keine Notizen vorhanden!'),
          )
        : 

  }
}

