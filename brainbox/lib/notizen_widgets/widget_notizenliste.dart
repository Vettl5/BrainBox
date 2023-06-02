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
    appState.checkIfNotizExists();
    List<dynamic> notiz = appState.notiz;                     //Liste mit Notizen
    
    Widget notizenListe = notiz.isEmpty == true               //Wenn überhaupt gar keine Notizen vorhanden sind
        
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

        : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: notiz.length,
                        itemBuilder: (context, index) {
                          return NotizListTileBuilder(
                            id: notiz[index].id,
                            text: notiz[index].text,
                            geloescht: notiz[index].geloescht,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      ),
                      SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ],
          );

    
    return notizenListe;
  }
}