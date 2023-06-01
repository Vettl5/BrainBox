import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notizen_builder/notiz_listtile_builder.dart';

/*----------------------------------NOTIZEN WIDGET GENERATOR-------------------------------------*/
 

class PapierkorbListe extends StatefulWidget {
  const PapierkorbListe({super.key});
  @override
  State<PapierkorbListe> createState() => _PapierkorbListeState();
}

class _PapierkorbListeState extends State<PapierkorbListe> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return buildPapierkorbListe(appState);                                     
  }

  Widget buildPapierkorbListe(MyAppState appState) {
    List<dynamic> papierkorb = appState.zuletztgeloescht;            //Liste mit Notizen
    
    Widget papierkorbListe = papierkorb.isEmpty == true              //Wenn überhaupt gar keine Notizen vorhanden sind
        
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Keine gelöschten Notizen vorhanden!",
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
            itemCount: papierkorb.length,
            itemBuilder: (context, index) {
              return NotizListTileBuilder(                // Übergabe von Listenelement Parametern an NotizListTileBuilder
                id: papierkorb[index].id,
                text: papierkorb[index].text,
                geloescht: papierkorb[index].geloescht,
              );
            },
          );
    
    return papierkorbListe;
  }
}


/*ListView.builder(                                     //Notizen mit runder Checkbox davor anzeigen
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: papierkorb.length,
            itemBuilder: (context, index) {
              NotizModel geloeschteNotiz = papierkorb[index];
              return NotizModelBuilder(
                notiz: geloeschteNotiz,                            // Übergabe vo Listenelement an NotizModelBuilder
              );
            },
          );*/
