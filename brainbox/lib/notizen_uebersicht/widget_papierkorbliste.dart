import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'papierkorb_model_builder.dart';

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
    appState.ladenPapierkorb();
    List<dynamic> notiz = appState.zuletztgeloescht;            //Liste mit Notizen
    
    Widget papierkorbListe = notiz.isEmpty == true                 //Wenn überhaupt gar keine Notizen vorhanden sind
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
        : ListView.builder(                                     //Notizen mit runder Checkbox davor anzeigen
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: notiz.length,
            itemBuilder: (context, index) {
              PapierkorbModel currentNotiz = notiz[index];
              return PapierkorbModelBuilder(
                notiz: currentNotiz,                            // Übergabe vo Listenelement an NotizModelBuilder
              );
            },
          );
    
    return notizenListe;
  }
}

