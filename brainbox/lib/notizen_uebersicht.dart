//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

import 'main.dart';
//import 'notizen_bearbeiten.dart';

/*----------------------------------------------------------------------------------------------*/

class Notizen extends StatefulWidget {
  const Notizen({super.key});
  @override
  State<Notizen> createState() => _NotizenState();
}


class _NotizenState extends State<Notizen> {
  
  @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();
    return buildNotizenListe(appState);                                     
  }

  Widget buildNotizenListe(MyAppState appState) {
    List<String> notizenname = appState.notizenname;
    if (notizenname.isEmpty) {
      return Center(
        child: Text('Du hast noch keine Notizen erstellt.'),
      );
    }

    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: appState.notizenname.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: _isDeleting ? Checkbox(value: false, onChanged: (value) { }) : null,
            title: Text(notizenname[index]),
            onTap: () {
              //openAndEditFile(context, File(appState.notizen[index]));
            },
          );
        },
      ),
      /*ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [

                for (var notiz in notizenname)
                  ListTile(
                    title: Text(notiz),
                    onTap: () {
                      //openAndEditFile(context, File(notiz));
                      //Navigator.pushNamed(context, '/bearbeiten', arguments: {'file': File(notiz)});
                    },
                  ),
                  
              ],
            ),*/
    );
  }
}

//var appState =  MyAppState();
  //late MyAppState appState;

  /*@override
  void initState() {
    super.initState();
    appState = MyAppState();
  }*/

/*return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: appState.notizenname.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appState.notizenname[index]),
            onTap: () {
              openAndEditFile(context, File(appState.notizen[index]));
            },
          );
        },*/
