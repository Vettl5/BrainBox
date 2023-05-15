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

  @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();
    return appBarWidgetBuilder(appState);
  }

  Widget appBarWidgetBuilder (MyAppState appState) {
        //AppBar, wenn Optionsmenü nicht getriggert wurde
        return AppBar(
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
                            //Papierkorb öffnen:
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Gelöschte Notizen'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/papierkorb');
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
          );
  }
}
    
  //wird nicht mehr benötigt, da AppBar sich nicht mehr ändert
    
  /*void changeAppBarState() {                                //sich ändernde Appbar, wenn Option in Optionsmenü ausgewählt wurde
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
  }*/

  