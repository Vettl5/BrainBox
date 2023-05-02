//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
//import 'notizen_bearbeiten.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class Notizen extends StatefulWidget {
  const Notizen({super.key});
  @override
  State<Notizen> createState() => _NotizenState();
}


class _NotizenState extends State<Notizen> {
  bool _isDeleting = false;                                 //Löschfunktion ausgewählt
  var appBarStateIndex = 0;


  /*----------------------------------APPBAR State Change Funktion, wird aktiviert wenn getriggert durch Optionsmenü-------------------------------------*/
  void changeAppBarState() {                                //sich ändernde Appbar, wenn Option in Optionsmenü ausgewählt wurde
    setState(() {
      if (appBarStateIndex == 0) {
        appBarStateIndex = 1;                               //Löschfunktion ausgewählt
      } else {
        appBarStateIndex = 0;                               //zurück zu normaler AppBar
      }
    });
  }

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

    /*--------------------------------------------------------APPBAR, abhängig von jeweiligem Zustand-----------------------------------------------------------*/
    Widget appBarWidget = appBarStateIndex == 0 
        //AppBar, wenn Optionsmenü nicht getriggert wurde
        ? AppBar(
            title: const Text('BrainBox', 
              style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(                                                                     //Optionmenü Button
                icon: const Icon(Icons.more_vert, size: 30, color: Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Notizen Löschen'),                                 //Option #1
                              onTap: () {
                                setState(() {
                                  _isDeleting = true;
                                  changeAppBarState();
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Wählen Sie die Notiz aus, die Sie löschen möchten!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            //Noch ohne Funktion:
                            /*ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('Umbenennen'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),*/
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          )
        //AppBar, wenn Optionsmenü getriggert wurde ("Löschen" ausgewählt)  
        : AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isDeleting = false;
                  changeAppBarState();
                });
              },
            ),
            title: const Text('BrainBox', 
              style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(                                                                     //Options Button
                icon: const Icon(Icons.delete, size: 30, color: Colors.white),
                onPressed: () {
                  AlertDialog(
                    title: Text('Notiz löschen'),
                    content: Text('Möchten Sie die Notiz wirklich löschen?'),
                    actions: [
                      TextButton(
                        child: Text('Abbrechen'),
                        onPressed: () {
                          setState(() {
                            _isDeleting = false;
                            changeAppBarState();
                          });
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Löschen'),
                        onPressed: () {
                          setState(() {
                            _isDeleting = false;
                            changeAppBarState();
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              )
            ],
        );

    Widget emptyListChecker = notizenname.isEmpty == true
        ? Center(
            child: Text('Keine Notizen vorhanden!'),
          )
        : ListView.builder(                                             //Auflistung der Notizen
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: appState.notizenname.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: _isDeleting                              //Checkbox, um zu löschende Notizen auszuwählen
                            ? Checkbox(                               //wenn _isDeleting true ist, wird Checkbox angezeigt
                                checkColor: Colors.white, 
                                fillColor: MaterialStateProperty.resolveWith(getColor), 
                                value: false, onChanged: (value) {
                                  setState(() {
                                    _isDeleting = value!;
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
              );

    /*--------------------------------------------------------LISTVIEW-----------------------------------------------------------*/
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              appBarWidget,                                           //Aufruf der AppBar
              emptyListChecker,
            ],
          );
        },
      ),
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
