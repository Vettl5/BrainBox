//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'widget_appbar.dart';
import 'widget_papierkorbliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class PapierkorbUebersicht extends StatefulWidget {
  const PapierkorbUebersicht({super.key});
  @override
  State<PapierkorbUebersicht> createState() => _PapierkorbUebState();
}


class _PapierkorbUebState extends State<PapierkorbUebersicht> { 

  @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();
    return buildPapierkorbListe(appState);                                     
  }

  Widget buildPapierkorbListe(MyAppState appState) {
    /*--------------------------------------------------------LISTVIEW-----------------------------------------------------------*/
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              MyAppBar(),                         //Generierung der AppBar(abhängig von _isDeleting)
              PapierkorbListe(),                     //Generierung der Notizenliste
            ],
          );
        },
      ),
    );

  }
}