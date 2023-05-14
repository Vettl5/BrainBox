import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'notiz_model_builder.dart';

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
    appState.ladenNotizen();
    List<dynamic> notiz = appState.notiz;                     //Liste mit Notizen
    
    Widget notizenListe = notiz.isEmpty == true               //Wenn überhaupt gar keine Notizen vorhanden sind
        ? Center(
            child: Text('Keine Notizen vorhanden!'),
          )
        : ListView.builder(                                         //Notizen mit runder Checkbox davor anzeigen
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: notiz.length,
            itemBuilder: (context, index) {
              NotizModel currentNotiz = notiz[index];
              return NotizModelBuilder(
                notiz: currentNotiz,
              );
            },
          );
    
    return notizenListe;
  }
}

