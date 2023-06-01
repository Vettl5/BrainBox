//Notizenübersicht auf Homescreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notizen_widgets/widget_notizenliste.dart';

/*-----------------------------------------------------NOTIZEN ÜBERSICHT----------------------------------------------------------*/

class NotizenUebersicht extends StatefulWidget {
  NotizenUebersicht({Key? key,}) : super(key: key);
  @override
  State<NotizenUebersicht> createState() => _NotizenUebState();
}


class _NotizenUebState extends State<NotizenUebersicht> { 
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  void submitForm(MyAppState appState) {
    if (_formKey.currentState!.validate()) {
      final text = _nameController.text;
      appState.hinzufuegenNotiz(text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notiz erstellt!'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      _nameController.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();
    return _buildNotizenListe(appState);                                     
  }

  Widget _buildNotizenListe(MyAppState appState) {
    /*--------------------------------------------------------LISTVIEW-----------------------------------------------------------*/
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
                title: const Text('BrainBox', 
                  style: TextStyle(
                    fontSize: 27, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                  ),
                ),
                centerTitle: true, // Text wird in der Mitte zentriert
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
      body: NotizenListTile(),                   //Generierung der Notizenliste

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Notiz hinzufügen'),
              content: SizedBox(
                width: 300, // Legen Sie die gewünschte Breite fest
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sie müssen einen gültigen Namen vergeben!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name der Notiz:',
                        labelText: 'Notizname',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              
              actions: [
                TextButton(
                  child: Text('Abbrechen'),
                  onPressed: () {
                    _nameController.clear();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Erstellen'),
                  onPressed: () {
                    submitForm(appState);                                        //Gültigkeit der Eingabe wird geprüft
                  },
                ),
              ],
            ),
            barrierDismissible: false,
          );
        },
      ),
    );
  }
}

/*return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              AppBar(
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
                                  leading: Icon(Icons.delete),
                                  title: Text('Gelöschte Notizen wiederherstellen'),
                                  onTap: () {
                                    widget.onToggleIndex(1);    // Aufruf der Callback-Funktion
                                    Navigator.pop(context);
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
              ),
              NotizenListe(),                     //Generierung der Notizenliste
            ],
          );
        },
      ),
    );*/