//Erstellt eine ListView mit allen Notizen, die in der Liste zuletztgeloescht in main.dart gespeichert sind

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notizen_builder/notiz_listtile_builder.dart';

/*----------------------------------PAPIERKORB WIDGET GENERATOR-------------------------------------*/
 

class PapierkorbListe extends StatefulWidget {
  const PapierkorbListe({super.key});
  @override
  State<PapierkorbListe> createState() => _PapierkorbListeState();
}

class _PapierkorbListeState extends State<PapierkorbListe> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return _buildPapierkorbListe(appState);                                     
  }

  Widget _buildPapierkorbListe(MyAppState appState) {
    List<dynamic> papierkorb = appState.zuletztgeloescht;            //Lokale Kopie der Notizen aus appState.zuletztgeloescht (main.dart)
    
    Widget papierkorbListe = papierkorb.isEmpty == true              //Wenn überhaupt gar keine Notizen vorhanden sind
        
        //------------------------------------------------LEERES FELD MIT TEXT-----------------------------------------------//
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Keine gelöschten Notizen vorhanden!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          )
        
        //------------------------------------------------LISTVIEW ALLER NOTIZEN IM PAPIERKORB-----------------------------------------------/
        : ListView.separated(                               //Listview mit Trennstrichen zwischen den einzelnen Notizen
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: papierkorb.length,                   //Anzahl der Listtiles = Anzahl der Notizen in appState.zuletztgeloescht[]
            itemBuilder: (context, index) {
              return NotizListTileBuilder(                  // Übergabe von Listenelement Parametern an NotizListTileBuilder
                id: papierkorb[index].id,
                text: papierkorb[index].text,
                geloescht: papierkorb[index].geloescht,
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),       //für die Trennstriche
          );
    
    return papierkorbListe;
  }
}