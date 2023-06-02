//Erstellt eine ListView mit allen Notizen, die in der Liste notiz in main.dart gespeichert sind

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notizen_builder/notiz_listtile_builder.dart';

/*----------------------------------NOTIZEN WIDGET GENERATOR-------------------------------------*/

class NotizenListTiles extends StatefulWidget {
  const NotizenListTiles({super.key});
  @override
  State<NotizenListTiles> createState() => _NotizenListTilesState();
}

class _NotizenListTilesState extends State<NotizenListTiles> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return _buildNotizenListTile(appState);                                     
  }

  Widget _buildNotizenListTile(MyAppState appState) {
    appState.checkIfNotizExists();                            //initiiert Überprüfung in MyAppState (main.dart), ob Notizdateien existieren (wichtig beim ersten Start der App)
    List<dynamic> notiz = appState.notiz;                     //Lokale Kopie der Liste mit Notizen aus MyAppState() (main.dart)
    
    Widget notizenListe = notiz.isEmpty == true               //Wenn überhaupt gar keine Notizen vorhanden sind
        
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
                    "Keine Notizen vorhanden! \n\n Erstelle eine neue Notiz, indem du auf das Plus klickst.",
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

        //------------------------------------------------LISTVIEW ALLER NOTIZEN-----------------------------------------------//
        : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(                                 //Listview mit Trennstrichen zwischen den einzelnen Notizen
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: notiz.length,                          //Anzahl der Listtiles = Anzahl der Notizen in appState.notizen[]
                        itemBuilder: (context, index) {
                          return NotizListTileBuilder(                    //Aufruf von NotizListTileBuilder in notiz_listtile_builder.dart und Übergabe der Notizdaten der Notiz am entsprechenden Index
                            id: notiz[index].id,
                            text: notiz[index].text,
                            geloescht: notiz[index].geloescht,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),     //für die Trennstriche
                      ),
                      SizedBox(height: 200),          //weißes Feld unterhalb des letzten Listtiles, um Editing-Button niemals zu überdecken durch Floating Action Button
                    ],
                  ),
                ),
              ),
            ],
          );

    
    return notizenListe;
  }
}