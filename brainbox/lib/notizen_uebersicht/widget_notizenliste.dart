import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

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
    List<String> notizenname = appState.notizenname;
    bool isDeleting = appState.isDeleting;                          //Checkboxen State (übergeben von widget_appbar.dart an MyAppState)
    bool isChecked = false;

    Widget notizenListe = notizenname.isEmpty == true               //Wenn überhaupt gar keine Notizen vorhanden sind
        ? Center(
            child: Text('Keine Notizen vorhanden!'),
          )
        : isDeleting == false
          ? ListView.builder(                                       //Wenn "Notizen löschen" nicht aktiviert ist
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: notizenname.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                          notizenname[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/bearbeiten');
                        },
                    );
                  },
                )
          : ListView.builder(                                             //Wenn "Notizen löschen" ausgewählt wurde
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: notizenname.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                        appState.loeschAuswahl(notizenname[index]);
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    title: Text(
                      notizenname[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
            );
    
    return notizenListe;
  }
}

