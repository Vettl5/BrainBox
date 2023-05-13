//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
//import '../notizen_bearbeiten.dart';
import 'widget_appbar.dart';
import 'widget_notizenliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class Notizen extends StatefulWidget {
  const Notizen({super.key});
  @override
  State<Notizen> createState() => _NotizenState();
}


class _NotizenState extends State<Notizen> {
  List notizen = [];                                             //Liste mit Notizen
  bool _isChecked = false;                                  //Checkboxen State (angetickt oder nicht)
  List<bool> _isCheckedList = [];                           //Liste der angetickten Notizen (if _isChecked true -> _isCheckedList true)
  

  /*----------------------------------APPBAR State Change Funktion, wird aktiviert wenn getriggert durch Optionsmenü-------------------------------------*/
  @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();
    return buildNotizenListe(appState);                                     
  }

  Widget buildNotizenListe(MyAppState appState) {

    /*--------------------------------------------------------LISTVIEW-----------------------------------------------------------*/
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              MyAppBar(),                         //Generierung der AppBar(abhängig von _isDeleting)
              NotizenListe(),                     //Generierung der Notizenliste
            ],
          );
        },
      ),
    );

  }
}