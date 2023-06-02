// Als Erweiterungsmöglichkeit beibehalten, aber während der Appprogrammierung vorerst verworfen
// Wird nur benötigt, falls jedes ListTile in widget_notizenliste.dart eine eigene Seite zum Bearbeiten der Notiz bekommt
// Momentan repräsentiert aber jedes ListTile die Notiz selbst und keinen Dateititel einer extra Datei!

import 'dart:io';
import 'package:flutter/material.dart';

void openAndEditFile(BuildContext context, File file) {
  Navigator.pushNamed(context, '/bearbeiten', arguments: {'file': file});
}


class NotizBearbeiten extends StatelessWidget {
  const NotizBearbeiten({super.key});
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var file = args['file'] as File;
    var text = file.readAsStringSync();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notiz bearbeiten'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: TextEditingController(text: text),
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      /*Text('Notiz bearbeiten', style: Theme.of(context).textTheme.displayMedium),
      Text('Hier werden deine Notizen angezeigt'),*/
    );
  }
}