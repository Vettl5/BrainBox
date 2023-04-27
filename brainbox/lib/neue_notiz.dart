// Zweck: Erstellen einer neuen Notiz
// Input: Name der Notiz
// Output: Neue Notiz wird erstellt

//Libraries:
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//Dateien:
import 'notizen_bearbeiten.dart';
//---------------------------------------------------------------------------------------------------------------

//Klassen:
class NeueNotiz extends StatefulWidget {
  const NeueNotiz({super.key});                                               //Konstruktor für NeueNotiz
  @override
  State<NeueNotiz> createState() => _NeueNotizState();                        //State für NeueNotiz wird erstellt
}

class _NeueNotizState extends State<NeueNotiz> {                              //State Klasse für NeueNotiz; Private Klasse, da nur in NeueNotiz verwendet
  final _formKey = GlobalKey<FormState>();                                    //GlobalKey für Formular, um Eingabe zu überprüfen, durch validator (s.u.)
  final TextEditingController _nameController = TextEditingController();      //Controller für Eingabe des Namens der Notiz
  final _platform = Platform();                                               // Plattform wird initialisiert, um Pfad zu bekommen
  List<String> notizen = [];                                                  // Liste der Notizen wird initialisiert, soll Namen speichern
  
  void _submitForm() {                                                        //Funktion, die die Notiz erstellt, speichert und öffnen veranlasst
    if (_formKey.currentState!.validate()) {                                  //Wenn Eingabe valide, dann Datei generieren, sonst siehe validator (s.u.)
      final name = _nameController.text;
      if (name.isNotEmpty) {
        addNotiz(name);                                                      //Übergibt Namen der Notiz an addNotiz() in main.dart
        
        //Sollte lieber in main.dart passieren, da dort auch die Liste der Notizen verwaltet wird
        /*Navigator.pop(context);                                     //Schließt aktuelle Seite
        Navigator.pushNamed(context, '/bearbeiten', arguments: notiz);  //Öffnet NotizBearbeiten() mit der erstellten Notiz*/
      }
    }
  }

  Future<Directory> getApplicationDocumentsDirectory() async {
    final String? path = await _platform.getApplicationDocumentsDirectory();
    if (path == null) {
      throw MissingPlatformDirectoryException(
        'Unable to get application documents directory');
    }
    return Directory(path);
  }


  void addNotiz(String name) {
    final newFilePath = '$getApplicationDocumentsDirectory.path/$name.txt';           // Pfad der neuen .txt-Datei
    final newFile = File(newFilePath);                                                // neue .txt-Datei wird erstellt
    notizen.add(name);                                                                // Notizname zur Liste der Notizen hinzufügen
    openAndEditFile(context, newFile);                                                // Notiz als .txt-Datei speichern
    }

  void removeNotiz(String name) {
    final filePath = '$getApplicationDocumentsDirectory.path/$name.txt';
    final file = File(filePath);
    file.deleteSync();                                                                // .txt-Datei aus Pfad löschen
    notizen.remove(name);                                                             // Notizname aus Liste der Notizen entfernen
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(                                                             //Eingabeformular Feld
            key: _formKey,                                                  //Debugging Key für aktuelles Formular, macht Eingabe überprüfbar/zuweisbar
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
            onPressed: _submitForm,                                         //Gültigkeit der Eingabe wird geprüft
            child: Text('Erstellen'),
          ),  //ElevatedButton
        ],  //children
      ),  //Column
    ); //Center
  } //Widget build
} //NeueNotizState