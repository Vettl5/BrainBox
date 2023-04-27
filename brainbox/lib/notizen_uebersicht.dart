//Notizenübersicht auf Homescreen

import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'main.dart';
import 'notizen_bearbeiten.dart';

/*----------------------------------------------------------------------------------------------*/

class Notizen extends StatefulWidget {
  const Notizen({super.key});
  @override
  State<Notizen> createState() => _NotizenState();
}



class _NotizenState extends State<Notizen> {
  late final MyAppState appState;

  @override
  void initState() {
    super.initState();
    appState = MyAppState();
  }

  @override
  Widget build(BuildContext context) {   
    return buildNotizenListe();                                     
  }

  Widget buildNotizenListe() {
    if (appState.notizen.isEmpty) {
      return Text('Du hast noch keine Notizen erstellt.');
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: appState.notizen.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appState.notizen[index]),
            onTap: () {
              openAndEditFile(context, File(appState.notizen[index]));
            },
          );
        },
      );
    }
  }
}
