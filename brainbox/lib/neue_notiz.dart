// Zweck: Erstellen einer neuen Notiz
// Input: Name der Notiz
// Output: Neue Notiz wird erstellt

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'notizen_bearbeiten.dart';

class NeueNotiz extends StatefulWidget {
  const NeueNotiz({super.key});
  @override
  State<NeueNotiz> createState() => _NeueNotizState();
}

class _NeueNotizState extends State<NeueNotiz> {                  //Neue Notiz, die in einem String gespeichert werden soll und benannt werden kann
  var appState;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    appState = context.read<MyAppState>();
  }

  void _submitForm() {                                            //Funktion, die die Notiz erstellt, speichert und öffnen veranlasst
  if (_formKey.currentState!.validate()) {                        //Wenn Eingabe valide, dann Datei generieren, sonst siehe validator (s.u.)
    final name = _nameController.text;
    if (name.isNotEmpty) {
      final newFilePath = appState.appDocumentsDir.path + '/' + name + '.txt';
      final newFile = File(newFilePath);
      openAndEditFile(context, newFile);
    }
  }
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