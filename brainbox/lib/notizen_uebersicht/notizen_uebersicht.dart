//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notizen_widgets/widget_notizenliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class NotizenUebersicht extends StatefulWidget {
  final Function(int) onToggleIndex;

  NotizenUebersicht({
    Key? key, 
    required this.onToggleIndex,}) : super(key: key);
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
              AppBar(
                title: const Text('BrainBox', 
                  style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                actions: [
                  IconButton(                                                                     //Optionmenü Button
                    icon: const Icon(Icons.more_vert, size: 30, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                //Papierkorb öffnen:
                                ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Gelöschte Notizen wiederherstellen'),
                                  onTap: () {
                                    widget.onToggleIndex(1);    // Aufruf der Callback-Funktion
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              NotizenListe(),                     //Generierung der Notizenliste
            ],
          );
        },
      ),
    );
  }
}