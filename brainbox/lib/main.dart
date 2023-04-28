//import 'dart:io';
//import 'package:path/path.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'neue_notiz.dart';
import 'notizen_bearbeiten.dart';
import 'notizen_uebersicht.dart';
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
        },
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  Future<Directory?>? _appDocumentsDirectory;
  List<String> notizen = [];                                       // Liste der Notizen wird initialisiert, soll Namen speichern

  void _requestAppDocumentsDirectory() {                           // Funktion, die den Pfad des Ordners der App speichert
    _appDocumentsDirectory = getApplicationDocumentsDirectory();
  }

  void addNotiz(String name) {                                                        // Funktion, die Notiz zur Liste hinzufügt
    _requestAppDocumentsDirectory();
    final newFilePath = '$_appDocumentsDirectory/$name.txt';                          // Pfad der neuen .txt-Datei
    final newFile = File(newFilePath);                                                // neue .txt-Datei wird erstellt
    notizen.add(name);                                                                // Notizname zur Liste der Notizen hinzufügen
    Text('Notiz $name wurde erstellt! Sie können sie in der Übersicht einsehen!');
    notifyListeners();                                                                // Listener wird benachrichtigt, dass eine Notiz hinzugefügt wurde
    //openAndEditFile(context, newFile);
  }
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
                child: BottomAppBar(
                  child: BottomNavigationBar(                     //error-causing widget
                    //backgroundColor: Colors.white,
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
              ),
            ],
          );
        },
      ),
      /*body: Column(
        children: [
          SafeArea(
            child: Container(
              ,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ), 
            page,
          ),
          
          
          SafeArea(
            child: BottomAppBar(
              child: BottomNavigationBar(                     //error-causing widget
                //backgroundColor: Colors.white,
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
          ),
        ],
      ),*/
    );
  }
}


/*body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
      //Noch nicht perfekt, aber BottomNavigationBar rutscht nicht nach unten weg. Container ist momentan nur so breit wie Text lang ist
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Notizen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Neue Notiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: selectedIndex,       
          onTap: (value) {                     
            setState(() {                     
              selectedIndex = value;                          //selectedIndex wird auf den Wert von value gesetzt, entsprechende page im nächsten reload     
              print(value);                                   //Ausgabe des Wertes von value in der Konsole, nur zur Kontrolle                   
              }
            );                                
          },
        ),
      ),*/


  //Alte Version
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