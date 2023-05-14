//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'widget_appbar.dart';
import 'widget_notizenliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class NotizenUebersicht extends StatefulWidget {
  const NotizenUebersicht({super.key});
  @override
  State<NotizenUebersicht> createState() => _NotizenUebState();
}


class _NotizenUebState extends State<NotizenUebersicht> { 

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