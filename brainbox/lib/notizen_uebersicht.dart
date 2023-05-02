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
  bool _isDeleting = false;
  var appBarStateIndex = 0;

  //Funktion, um AppBar zu wechseln
    void changeAppBarState() {
      setState(() {
        if (appBarStateIndex == 0) {
          appBarStateIndex = 1;
        } else {
          appBarStateIndex = 0;
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
    if (notizenname.isEmpty) {
      return Center(
        child: Text('Du hast noch keine Notizen erstellt.'),
      );
    }

    Widget AppBarWidget = appBarStateIndex == 0 
        ? AppBar(
            title: const Text('BrainBox'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(                                                                     //Options Button
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
                              title: Text('Notizen Löschen'),
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
            ]
          )
        : AppBar(
            title: const Text('BrainBox'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(                                                                     //Options Button
                icon: const Icon(Icons.delete, size: 30, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Wirklich löschen?'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                },
              )
            ]
        );


    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              AppBarWidget,
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: appState.notizenname.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: _isDeleting 
                            ? Checkbox(value: false, onChanged: (value) { }) : null,
                    title: Text(notizenname[index]),
                    onTap: () {
                      //openAndEditFile(context, File(appState.notizen[index]));
                    },
                  );
                },
              ),
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
