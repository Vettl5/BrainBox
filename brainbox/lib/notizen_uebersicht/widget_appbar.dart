import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
//import 'widget_notizen.dart';

/*---------------------ausgelagerte Widgets für Notizenübersicht-----------------------------*/

class MyAppBar extends StatefulWidget {
  const MyAppBar ({super.key});
  @override
  State<MyAppBar> createState() => _AppBarState();
  }


class _AppBarState extends State<MyAppBar> {
  bool _isDeleting = false;                                //Checkboxen State (angetickt oder nicht)
  var appBarStateIndex = 0;

  void changeAppBarState() {                                //sich ändernde Appbar, wenn Option in Optionsmenü ausgewählt wurde
    setState(() {
      if (appBarStateIndex == 0) {
        appBarStateIndex = 1;                               //Löschfunktion ausgewählt
        Provider.of<MyAppState>(context, listen: false).deleteState(_isDeleting);    
      } else {
        appBarStateIndex = 0;                               //zurück zu normaler AppBar
        Provider.of<MyAppState>(context, listen: false).deleteState(_isDeleting);
      }
      //_isDeleting
    });
  }

  @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();
    return appBarWidgetBuilder(appState);
  }

  Widget appBarWidgetBuilder (MyAppState appState) {
    
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
                            //Notizen löschen, aktiviert Checkboxen in widget_notizen.dart:
                            ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Notizen Löschen'),         //Option #1
                              onTap: () {
                                setState(() {
                                  _isDeleting = true;
                                  changeAppBarState();
                                  // CheckboxViewer();                //aktiviert Checkboxen in widget_notizen.dart
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
                            //Einstellungen öffnen:
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Einstellungen'),           //Option #2
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/einstellungen');
                              },
                              
                            ),
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
                    content: Text('Möchten Sie die Notiz:en wirklich löschen?'),
                    actions: [
                      TextButton(
                        child: Text('Abbrechen'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Löschen'),
                        onPressed: () {
                          setState(() {
                            appState.removeNotizen();
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

  return appBarWidget;
  }
}
    
  