//import 'dart:io';
//import 'package:path/path.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'neue_notiz.dart';
import 'notizen_bearbeiten.dart';
import 'notizen_uebersicht/notizen_uebersicht.dart';
//import 'einstellungen.dart';

/*----------------------------------------------------------------------------------------------------------*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {                             //Definiert einige Randdetails der App
  const MyApp({super.key});                                       //Konstruktor für MyApp

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(                                //ein Widget, das die Daten an alle Widgets weitergibt
      create: (context) => MyAppState(),                          //erstellt eine Instanz von MyAppState
      child: MaterialApp(
        title: 'BrainBox',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 92, 124, 182)),
        ),
        home: MyHomePage(),                                       //Startseite der App, leitet durch selectedIndex=0 zu Notizen() weiter
        routes: {
          '/bearbeiten': (context) => NotizBearbeiten(),          //leitet zu NotizBearbeiten() weiter, wichtig für neue_notiz (Navigator.pushNamed...)
          '/einstellungen':(context) => Placeholder(),          //leitet zu Einstellungen() weiter, wichtig für notizen_uebersicht (Navigator.pushNamed...)
        },
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  Future<Directory?>? _appDocumentsDirectory;
  String inhalt;
  List<String> notes = [note(),];
  bool isChecked;

  Note({
    required this.inhalt,
    this.isChecked = false,
  });


  /*notiz ({
    required this.inhalt,
    required this._isChecked,
    //bool get isChecked => _isChecked,                               // public bool für widget_notizenliste.dart
    List<String> tickedForDeletion = [],                              // zum löschen ausgewählte Notizen
  })*/

  MyAppState() {                                                    // Konstruktor für MyAppState, wird beim Start der App aufgerufen
    _requestAppDocumentsDirectory();                                
    //loadNotizen();                                                
  }

  void loeschAuswahl(String value) {
    if (!tickedForDeletion.contains(value)) {
      tickedForDeletion.add(value);
    } else {
      tickedForDeletion.remove(value);
    }
    notifyListeners();
  }

  void _requestAppDocumentsDirectory() {                            // Funktion, die den Pfad des Ordners der App speichert
    _appDocumentsDirectory = getApplicationDocumentsDirectory();    // speichert einmalig den Pfad des Ordners der App in _appDocumentsDirectory
  }

  void addNotiz(String name) {                                                        // Funktion, die Notiz zur Liste hinzufügt
    /*final newFilePath = '$_appDocumentsDirectory/$name.txt';                          // Pfad der neuen .txt-Datei
    final newFile = File(newFilePath);                                                // Erzeugt Objekt vom Typ File im Pfad von newFilePath
    newFile.createSync(); */                                                            // legt neue .txt-Datei im Pfad von newFilePath an
    notiz.inhalt.add(name);                                                            // Notizname zur Liste der Notizen hinzufügen
    notifyListeners();
  }

  
  void removeNotizen() {
    for (String notizname in tickedForDeletion) {
      notizenname.remove(notizname);
      final filePath = '$_appDocumentsDirectory/$notizname.txt';
      final file = File(filePath);
      file.deleteSync();
    }
    tickedForDeletion.clear();
    notifyListeners();
  }
}

/*----------------------------------------------------------------------------------------------------------*/
//StatefulWidget nötig, da sich die Startseite entsprechend des selectedIndex ändert (Notizenübersicht, Neue Notiz, Einstellungen)

class MyHomePage extends StatefulWidget {                           //Widget von MyHomePage (quasi gesamter Bildschirm)
  const MyHomePage({super.key});                                    //Konstruktor für MyHomePage
  @override
  State<MyHomePage> createState() => _MyHomePageState();            //State für MyHomePage wird erstellt
}


class _MyHomePageState extends State<MyHomePage> {                  //State Klasse für MyHomePage; Private Klasse, da nur in MyHomePage verwendet
  var selectedIndex = 0;                                           //Variable selectedIndex mit Wert 0 (Startseite) wird erstellt
  

  @override
  Widget build(BuildContext context) {
    
    Widget page;
    switch (selectedIndex) {
    case 0:
      page = Notizen();                           //Notizenübersicht, Startseite
      break;
    case 1:
      page = NeueNotiz();                         //Neue Notiz anlegen und anschließend öffnen
      break;
    default:
      throw UnimplementedError('No widget for $selectedIndex');       //Just in case
    }

    var mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(child: mainArea),
              SafeArea(
                child: BottomNavigationBar(
                  backgroundColor: Color.fromARGB(255, 167, 213, 255),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(                          //Notizenübesicht, Startseite
                      icon: Icon(Icons.menu),         
                      label: 'Notizen',
                    ),
                    BottomNavigationBarItem(                          //Neue Notiz anlegen
                      icon: Icon(Icons.add_circle_outline),     
                      label: 'Neue Notiz',
                    ),
                  ],
                  currentIndex: selectedIndex,       
                  onTap: (value) {                     
                    setState(() {                     
                      selectedIndex = value;                          //selectedIndex wird auf den Wert von value gesetzt, entsprechende page im nächsten reload     
                      print(value);                                   //Ausgabe des Wertes von value in der Konsole, nur zur Kontrolle                   
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


  //wird nötig, wenn Notizen aus Speicher geladen werden sollen
  /*void loadNotizen() async {                                        // Funktion, die die Liste der Notizen neu lädt (wird bei Änderungen aufgerufen, um z.B. notizen_uebersicht.dart zu aktualisieren)
    final appDocumentsDirectory = await _appDocumentsDirectory;     // _appDocumentsDirectory muss in appDocumentsDirectory gespeichert werden, da _appDocumentsDirectory sonst nicht in der Funktion verwendet werden kann
    final files = appDocumentsDirectory!.listSync();                // Liste der Dateien im Ordner der App wird gespeichert
    notizenname = files
        .where((file) => file.path.endsWith('.txt'))                // Nur Dateien, die auf .txt enden, werden ausgewählt
        .map((file) => file.path).toList();                         // Namen der Dateien werden zur Liste der Notizen hinzugefügt
    notifyListeners();                                              // Listener wird benachrichtigt, dass die Notizen geladen wurden
  }*/