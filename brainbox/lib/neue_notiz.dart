// Zweck: Erstellen einer neuen Notiz
// Input: Name der Notiz
// Output: Neue Notiz wird erstellt

//Libraries:
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:path_provider/path_provider.dart';

//Dateien:
import 'main.dart';
//import 'notizen_bearbeiten.dart';
//---------------------------------------------------------------------------------------------------------------

//Klassen:
class NeueNotiz extends StatefulWidget {
  const NeueNotiz({Key? key}) : super(key: key);
  @override
  State<NeueNotiz> createState() => _NeueNotizState();
}

class _NeueNotizState extends State<NeueNotiz> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void submitForm() {                                                       //Funktion, die die Notiz erstellt, speichert und öffnen veranlasst
      if (_formKey.currentState!.validate()) {                                //Wenn Eingabe valide, dann
        final text = _nameController.text;
        appState.addNotiz(text);                                              //Übergibt Text der Notiz an addNotiz() in main.dart --> MyAppState
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notiz erstellt!'),
            duration: Duration(milliseconds: 1500),
          ),
        );
        _nameController.clear();                                              // Eingabefeld leeren
        //Navigator.pushNamed(context, '/bearbeiten', arguments: {'file': name});   //Öffnet NotizBearbeiten() mit der erstellten Notiz; Erweiterungsoption
      }
    }

    return Scaffold(
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
                ),
              SizedBox(height: 20.0),                                           //Abstandshalter zwischen AppBar und Textfeld
              Form(      
                //mainAxisAlignment: MainAxisAlignment.center,                                                       //Eingabeformular Feld
                key: _formKey,                                                  //Debugging Key für aktuelles Formular, macht Eingabe überprüfbar/zuweisbar
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: TextFormField(                                         //Textfeld, in dem der Name der Notiz eingegeben werden kann
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {                     //validator prüft, ob Eingabe ungültig ist
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
              SizedBox(height: 20.0),                                           //Abstandshalter zwischen Textfeld und Button
              ElevatedButton(
                onPressed: submitForm,                                         //Gültigkeit der Eingabe wird geprüft
                child: Text('Erstellen'),
              ),  //ElevatedButton
            ],  //children
          );  //Column
        },
      ), //Center
    );

  } //Widget build
} //NeueNotizState


        
        //Sollte lieber in main.dart passieren, da dort auch die Liste der Notizen verwaltet wird
        /*Navigator.pop(context);                                     //Schließt aktuelle Seite
        Navigator.pushNamed(context, '/bearbeiten', arguments: notiz);  //Öffnet NotizBearbeiten() mit der erstellten Notiz*/