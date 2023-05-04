//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
//import '../notizen_bearbeiten.dart';
import 'widget_appbar.dart';
import 'widget_notizenliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class Notizen extends StatefulWidget {
  const Notizen({super.key});
  @override
  State<Notizen> createState() => _NotizenState();
}


class _NotizenState extends State<Notizen> {
  bool _isChecked = false;                                  //Checkboxen State (angetickt oder nicht)
  List<bool> _isCheckedList = [];                           //Liste der angetickten Notizen (if _isChecked true -> _isCheckedList true)
  

  /*----------------------------------APPBAR State Change Funktion, wird aktiviert wenn getriggert durch Optionsmenü-------------------------------------*/
   @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();
    return buildNotizenListe(appState);                                     
  }

  Widget buildNotizenListe(MyAppState appState) {
    List<String> notizenname = appState.notizenname;

    /*--------------------------------------------------------Color setter für Checkboxen-----------------------------------------------------------*/
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    //Widget Listenelemente

    Widget emptyListChecker = notizenname.isEmpty == true
        ? Center(
            child: Text('Keine Notizen vorhanden!'),
          )
        : ListView.builder(                                             //Auflistung der Notizen
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: notizenname.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    leading: _isDeleting                              //Checkbox, um zu löschende Notizen auszuwählen
                            ? Checkbox(                               //wenn _isDeleting true ist, wird Checkbox angezeigt
                                checkColor: Colors.white, 
                                fillColor: MaterialStateProperty.resolveWith(getColor), 
                                value: _isChecked, 
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ) 
                            : null,
                    
                    title: Text(notizenname[index]),
                    onTap: () {
                      //openAndEditFile(context, File(appState.notizen[index]));
                    },
                  );
                },
                //Divider();
                
              );

    /*--------------------------------------------------------LISTVIEW-----------------------------------------------------------*/
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              MyAppBar(),                         //Generierung der AppBar(abhängig von _isDeleting)
              NotizenListe(),                     //Generierung der Notizenliste
            ],
          );
        },
      ),
    );

  }
}