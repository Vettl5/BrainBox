import 'dart:io';
//import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'neue_notiz.dart';
import 'notizen_bearbeiten.dart';
import 'notizen_uebersicht.dart';
//import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {                             //Definiert einige Randdetails der App
  const MyApp({super.key});

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
        },
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  List<String> notizen = [];  // Liste der Notizen wird initialisiert, soll Namen speichern
  final _platform = Platform(); // Plattform wird initialisiert, um Pfad zu bekommen

  Future<Directory> getApplicationDocumentsDirectory() async {
    final String? path = await _platform.getApplicationDocumentsDirectory();
    if (path == null) {
      throw MissingPlatformDirectoryException(
        'Unable to get application documents directory');
    }
    return Directory(path);
  }

  
  /*String name = '';                                     //Variable name mit Wert '' (leerer String) wird erstellt
  String text = '';                                     //Variable text mit Wert [] (leere Liste) wird erstellt

  notiz (String name, String text){                     //Funktion notiz mit Parameter name und text wird erstellt
    this.name = name;
    this.text = text;
  }                                                     //Variable notiz mit Wert [] (leere Liste) wird erstellt

  void addNotiz(notiz) {                                              //Funktion addNotiz mit Parameter notiz wird erstellt
    notiz.add(notiz);                                                 //notiz wird der Liste notiz hinzugefügt
    notifyListeners();                                                //Änderung wird an alle Widgets weitergegeben
  }

  void removeNotiz(notiz) {                                           //Funktion removeNotiz mit Parameter notiz wird erstellt
    notiz.remove(notiz);                                              //notiz wird aus der Liste notiz entfernt
    notifyListeners();                                                //Änderung wird an alle Widgets weitergegeben
  }*/

  /*Directory? _appDocumentsDir;                                        //Variable appDocumentsDir mit Klasse Directory linken
  Directory? get appDocumentsDir => _appDocumentsDir;                   //Getter für appDocumentsDir

  void setAppDocumentsDir(Directory dir) {                              //Setter für appDocumentsDir
    _appDocumentsDir = dir;                                             //appDocumentsDir wird mit dir verlinkt
    notifyListeners();                                                  //Änderung wird an alle Widgets weitergegeben
  }*/
  
}
 

class MyHomePage extends StatefulWidget {                           //Widget von MyHomePage (quasi gesamter Bildschirm)
  const MyHomePage({super.key});                                    //Konstruktor für MyHomePage
  @override
  State<MyHomePage> createState() => _MyHomePageState();            //State für MyHomePage wird erstellt
}

class _MyHomePageState extends State<MyHomePage> {                  //State Klasse für MyHomePage; Private Klasse, da nur in MyHomePage verwendet
  
  var selectedIndex = 0;                          //Variable selectedIndex mit Wert 0 (Startseite) wird erstellt
  
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
    case 2:
      page = Placeholder();                       //wird Einstellungen Seite, noch ungenutzt
      break;
    default:
      throw UnimplementedError('no widget for $selectedIndex');       //Just in case
    }

    return Scaffold(
      body: Column(
        children: [
          SafeArea(                                 //oberes Widget, Page (s.o.) (SafeArea bewirkt Barrierefreiheit ggü. Notch etc.)
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,                          //Variable page aufrufen als Inhalt; basierend auf selectedIndex wird die entsprechende Seite aufgerufen
            ),
          ),
          BottomAppBar(                             //Untere Leiste, BottomAppBar mit BottomNavigationBar Buttons
            child: BottomNavigationBar(
              backgroundColor: Colors.white,                    //Hintergrundfarbe    
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(                          //Notizenübesicht, Startseite
                  icon: Icon(Icons.menu),         
                  label: 'Notizen',
                ),
                BottomNavigationBarItem(                          //Neue Notiz anlegen
                  icon: Icon(Icons.add_circle_outline),     
                  label: 'Neue Notiz',
                ),
                BottomNavigationBarItem(                          //Einstellungen
                  icon: Icon(Icons.settings),     
                  label: 'Settings',
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
      ),
    );
  }
}