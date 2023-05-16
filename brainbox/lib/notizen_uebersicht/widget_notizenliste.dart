import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notizen_uebersicht/notiz_listtile_builder.dart';

/*----------------------------------NOTIZEN WIDGET GENERATOR-------------------------------------*/
 

class NotizenListe extends StatefulWidget {
  const NotizenListe({super.key});
  @override
  State<NotizenListe> createState() => _NotizenListeState();
}

class _NotizenListeState extends State<NotizenListe> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return buildNotizenListe(appState);                                     
  }

  Widget buildNotizenListe(MyAppState appState) {
    appState.checkIfNotizExists();
    List<dynamic> notiz = appState.notiz;                     //Liste mit Notizen
    
    Widget notizenListe = notiz.isEmpty == true               //Wenn überhaupt gar keine Notizen vorhanden sind
        
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Keine Notizen vorhanden!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          )

        : ListView.builder(                               //Notizen mit runder Checkbox davor anzeigen
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: notiz.length,
            itemBuilder: (context, index) {
              return NotizListTileBuilder(                // Übergabe von Listenelement Parametern an NotizListTileBuilder
                id: notiz[index].id,
                text: notiz[index].text,
                geloescht: notiz[index].geloescht,
              );
            },
          );
    
    return notizenListe;
  }
}

