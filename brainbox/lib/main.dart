//import 'dart:io';
//import 'package:path/path.dart';
import 'dart:io';                                           
import 'dart:convert';                                        // für json-Dateiarbeit                   
import 'package:path_provider/path_provider.dart';            // um Dateispeicherort zu finden und nutzen
import 'package:uuid/uuid.dart';                              // für id Generierung
import 'package:flutter/material.dart';                       // für UI
import 'package:provider/provider.dart';                      // für klassenübergreifenenden Zugriff auf Daten      

import 'neue_notiz.dart';
import 'notizen_bearbeiten.dart';
import 'notizen_uebersicht/notizen_uebersicht.dart';
import 'notizen_uebersicht/notiz_model_builder.dart';
//import 'einstellungen.dart';

/*----------------------------------------------------------------------------------------------------------*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {                             //Definiert einige Randdetails der App
  const MyApp({super.key});                                       //Konstruktor für MyApp

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(                                // ein Widget, das die Daten an alle Widgets weitergibt
      create: (context) => MyAppState(),                          // erstellt eine Instanz von MyAppState
      child: MaterialApp(
        title: 'BrainBox',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 92, 124, 182)),
        ),
        home: MyHomePage(),                                       // Startseite der App, leitet durch selectedIndex=0 zu Notizen() weiter
        routes: {
          '/bearbeiten': (context) => NotizBearbeiten(),          // leitet zu NotizBearbeiten() weiter, wichtig für neue_notiz (Navigator.pushNamed...)
          '/einstellungen':(context) => Placeholder(),            // leitet zu Einstellungen() weiter, wichtig für notizen_uebersicht (Navigator.pushNamed...)
        },
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  bool isChecked = false;
  List<dynamic> notiz = [];                          // Liste der Notizen (inhalt)
  List<dynamic> zuletztgeloescht = [];

  Future<void> ladenNotizen() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/notizen.json');

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final jsonList = json.decode(jsonString) as List<dynamic>;

      notiz = jsonList.map((item) => NotizModel.fromJson(item)).toList();
      //notiz = jsonList.map((item) => Map<String, dynamic>.from(item)).toList();
    }
  } 
  catch (e) {
    print('Fehler beim Laden der Notizen: $e');
  }
}


  Future<void> speichernNotizen() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/notizen.json');

      final jsonList = notiz.map((item) => item.toJson()).toList();
      final jsonString = json.encode(jsonList);

      await file.writeAsString(jsonString);
    } 
    catch (e) {
      print('Fehler beim Speichern der Notizen: $e');
    }
  }


  void hinzufuegenNotiz(String text) {
    final id = Uuid().toString();
    final notizmodel = NotizModel(id: id, text: text);
    notiz.add(notizmodel);
    speichernNotizen();
  }

  void aktualisierenNotiz(NotizModel notiz) {
    speichernNotizen();
  }

  Future<void> notizLoeschen(NotizModel notizentext) await {
    try {
      notiz.remove(notizentext);
      speichernNotizen();                             //speichernNotizen() wird aufgerufen, um notiz[] zu aktualisieren

      final directory = getApplicationDocumentsDirectory();
      final file = File('${directory.path}/papierkorb.json');

      final jsonList = zuletztgeloescht.map((item) => item.toJson()).toList();
      final jsonString = json.encode(jsonList);
      
      await file.writeAsString(jsonString);
    } 
    catch (e) {
      print('Fehler beim Löschen der Notiz: $e');
    }
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