//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'widget_papierkorbliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class PapierkorbUebersicht extends StatefulWidget {
  final Function(int) onToggleIndex;
  PapierkorbUebersicht({required this.onToggleIndex, Key? key}) : super(key: key);
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
              AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
                  onPressed: () {
                    widget.onToggleIndex(0); // Aufruf der Callback-Funktion
                  },
                ),
                title: const Text('Gelöschte Notizen', 
                  style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              PapierkorbListe(),                     //Generierung der Notizenliste
            ],
          );
        },
      ),
    );

  }
}