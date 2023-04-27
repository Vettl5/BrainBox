// Zweck: Erstellen einer neuen Notiz
// Input: Name der Notiz
// Output: Neue Notiz wird erstellt

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'notizen_bearbeiten.dart';

class NeueNotiz extends StatefulWidget {
  const NeueNotiz({super.key});                                   //Konstruktor für NeueNotiz
  @override
  State<NeueNotiz> createState() => _NeueNotizState();            //State für NeueNotiz wird erstellt
}

class _NeueNotizState extends State<NeueNotiz> {                  //State Klasse für NeueNotiz; Private Klasse, da nur in NeueNotiz verwendet
  final _formKey = GlobalKey<FormState>();                        //GlobalKey für Formular, um Eingabe zu überprüfen, durch validator (s.u.)
  final TextEditingController _nameController = TextEditingController();      //Controller für Eingabe des Namens der Notiz
  late MyAppState appState;                                       //Variable appState mit Klasse MyAppState linken

  void _submitForm() {                                            //Funktion, die die Notiz erstellt, speichert und öffnen veranlasst
  if (_formKey.currentState!.validate()) {                        //Wenn Eingabe valide, dann Datei generieren, sonst siehe validator (s.u.)
    final name = _nameController.text;
    if (name.isNotEmpty) {
      final notiz = Notiz(name: name);                            //Erstellt Notiz mit eingegebenem Namen
      appState.addNotiz(notiz);                                   //Fügt Notiz zu Liste hinzu
      Navigator.pop(context);                                     //Schließt aktuelle Seite
      Navigator.pushNamed(context, '/bearbeiten', arguments: notiz);  //Öffnet NotizBearbeiten() mit der erstellten Notiz
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