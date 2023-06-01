//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notizen_widgets/widget_papierkorbliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class PapierkorbUebersicht extends StatefulWidget {
  PapierkorbUebersicht({Key? key,}) : super(key: key);
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
      appBar: AppBar(
                title: const Text('Gelöschte Notizen', 
                  style: TextStyle(
                    fontSize: 27, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                  ),
                ),
                centerTitle: true, // Text wird in der Mitte zentriert
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Löschen bestätigen'),
                            content: Text('Möchten Sie wirklich alle Elemente löschen?'),
                            actions: [
                              TextButton(
                                child: Text('Abbrechen'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Löschen'),
                                onPressed: () {
                                  appState.bereinigePapierkorb();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
      body: PapierkorbListe(),                     //Generierung der Notizenliste
    );
  }
}
