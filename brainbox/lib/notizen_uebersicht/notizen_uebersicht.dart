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
  List<String> queue = [];
  bool isMessengerActive = false;
  SnackBar? activeSnackbar; // Referenz auf die aktuelle Snackbar

  //----------------------------------------------------SNACKBAR-MESSENGER----------------------------------------------------------*/
  void snackbarMessenger(BuildContext context, String text) {
    queue.add(text); // Text zur Warteschlange hinzufügen

    if (!isMessengerActive) { // Wenn der Snackbar-Messenger nicht aktiv ist
      showNextSnackbar(context); // Nächste Snackbar anzeigen
    } else {
      // Wenn der Snackbar-Messenger aktiv ist, wird die aktuelle Snackbar sofort geschlossen und die neue Snackbar wird angezeigt
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  void showNextSnackbar(BuildContext context) {
    if (queue.isNotEmpty) { // Wenn die Warteschlange nicht leer ist
      isMessengerActive = true; // Snackbar-Messenger ist aktiv

      activeSnackbar = SnackBar(
        content: Text(queue.first),
        duration: Duration(milliseconds: 5000),
      );

      ScaffoldMessenger.of(context).showSnackBar(activeSnackbar!).closed.then((_) {
        queue.removeAt(0); // Erste Nachricht aus der Warteschlange entfernen
        isMessengerActive = false; // Snackbar-Messenger ist nicht mehr aktiv
        activeSnackbar = null; // Aktive Snackbar löschen
        showNextSnackbar(context); // Nächste Snackbar anzeigen
      });
    }
  }


//----------------------------------------------------NOTIZENERSTELLUNG INITIIEREN----------------------------------------------------------*/
  void submitForm(MyAppState appState, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final text = _nameController.text;
      appState.hinzufuegenNotiz(text);
      snackbarMessenger(context, 'Notiz erstellt!');
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
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),         // Um Abstand zw. oberster Notiz und AppBar zu gewährleisten
        child: Stack(
          children: [
            NotizenListTiles(),                            // Generierung der Notizenliste durch externen Code

            // Fadeout-Effekt am unteren Rand der Notizenliste
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).colorScheme.background.withOpacity(1),
                      Theme.of(context).colorScheme.background.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

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
                  child: Text('Abbrechen'),                         //Abbrechen Button
                  onPressed: () {
                    _nameController.clear();                        //Textfeld wird geleert, damit bei Neuaufruf kein alter Text angezeigt wird           
                    Navigator.of(context).pop();                    //Dialog wird geschlossen
                  },
                ),
                TextButton(
                  child: Text('Erstellen'),                         //Erstellen Button
                  onPressed: () {
                    submitForm(appState, context);                           //Gültigkeit der Eingabe wird geprüft
                  },
                ),
              ],
            ),
            barrierDismissible: false,                              //Dialog kann nicht durch Klicken außerhalb geschlossen werden
          );
        },
      ),
    );
  }
}