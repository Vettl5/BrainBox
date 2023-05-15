import 'dart:io';                                           
import 'dart:convert';                                        // für json-Dateiarbeit                   
import 'package:path_provider/path_provider.dart';            // um Dateispeicherort zu finden und nutzen
import 'package:uuid/uuid.dart';                              // für id Generierung
import 'package:flutter/material.dart';                       // für UI
import 'package:provider/provider.dart';                      // für klassenübergreifenenden Zugriff auf Daten 
//import 'package:shared_preferences/shared_preferences.dart'; // für dauerhafte Speicherung von Daten     

import 'neue_notiz.dart';
import 'notizen_oder_papierkorb_laden.dart';
import 'notizen_uebersicht/notiz_model_builder.dart';
import 'notizen_uebersicht/papierkorb_model_builder.dart';

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
          //'/notizen': (context) => NotizenUebersicht(),          // leitet zu NotizBearbeiten() weiter, wichtig für neue_notiz (Navigator.pushNamed...)
          //'/papierkorb':(context) => PapierkorbUebersicht(),            // leitet zu Einstellungen() weiter, wichtig für notizen_uebersicht (Navigator.pushNamed...)
        },
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  List<dynamic> notiz = <NotizModel>[];                          // Liste der Notizen (inhalt)
  List<dynamic> zuletztgeloescht = <NotizModel>[];
  final Uuid uuid = Uuid();

  /*--------------------------------------------Notizen--------------------------------------------------------------*/
  Future<void> checkIfNotizExists() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/notizen.json');

      if (await file.exists()) {
        ladenNotizen();
      } else {
        initialisiereNotizen();
      }
  }

  //wenn Notizdatei bereits existiert, lade Notizen
  Future<void> ladenNotizen() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/notizen.json');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonList = json.decode(jsonString) as List<dynamic>;
        notiz = jsonList.map((item) => NotizModel.fromJson(item)).toList();
      }
    } catch (e) {
      print('Fehler beim Laden der Notizen: $e');
    }
    notifyListeners();
  }

  //wenn Notizdatei noch nicht existiert, erstelle Notizdatei
  Future<void> initialisiereNotizen() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/notizen.json');

      if (!await file.exists()) {
        final jsonString = json.encode(notiz);
        await file.writeAsString(jsonString);
      }
    } catch (e) {
      print('Fehler beim Initialisieren der Notizen: $e');
    }
  }

  //Funktion soll notiz[] auslesen und JSON Datei aktualisieren
  Future<void> speichereNotizen() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/notizen.json');

      /*alt:
      //final jsonList = notiz.map((item) => item.toJson()).toList();*/

      //lese Array (in NotizModel Format, s.o.) aus & konvertiere es in eine Liste, verschlüssel die Liste im json Format
      final jsonString = json.encode(notiz.toList());

      //aktualisiere die Datei, indem verschlüsselte Liste als String in Datei geschrieben wird
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Fehler beim Speichern der Notizen: $e');
    }
  }

  /*--------------------------------------------Papierkorb------------------------------------------------------------*/
  Future<void> checkIfPapierkorbExists() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/papierkorb.json');

      if (await file.exists()) {
        ladenPapierkorb();
      } else {
        initialisierePapierkorb();
      }
  }

  //wenn Notizdatei bereits existiert, lade Notizen
  Future<void> ladenPapierkorb() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/papierkorb.json');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonList = json.decode(jsonString) as List<dynamic>;
        zuletztgeloescht = jsonList.map((item) => NotizModel.fromJson(item)).toList();
      }
    } catch (e) {
      print('Fehler beim Laden des Papierkorbs: $e');
    }
    notifyListeners();
  }

  //wenn Notizdatei noch nicht existiert, erstelle Notizdatei
  Future<void> initialisierePapierkorb() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/papierkorb.json');

      if (!await file.exists()) {
        final jsonString = json.encode(zuletztgeloescht);
        await file.writeAsString(jsonString);
      }
    } catch (e) {
      print('Fehler beim Initialisieren des Papierkorbs: $e');
    }
  }

  Future<void> speicherePapierkorb() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/papierkorb.json');

      //lese Array (in NotizModel Format, s.o.) aus & konvertiere es in eine Liste, verschlüssel die Liste im json Format
      final jsonString = json.encode(zuletztgeloescht.toList());

      //aktualisiere die Datei, indem verschlüsselte Liste als String in Datei geschrieben wird
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Fehler beim Speichern des Papierkorbs: $e');
    }
  }

  /*--------------------------------------------Dateiarbeit Funktionen------------------------------------------------------------*/
  void hinzufuegenNotiz(String text) {
    if(notiz.isEmpty) {                                             // falls Notiz hinzugefügt werden soll, aber Liste notiz[] noch leer ist
        initialisiereNotizen();
    }
    final notizmodel = NotizModel(id: uuid.v4(), text: text);       // Erstellt eine Instanz von NotizModel; übergibt id und text, isChecked kommt von NotizModel selbst
    notiz.add(notizmodel);                                          // Notiz in Daten-Modell Form wird in Liste notiz[] gespeichert
    speichereNotizen();                                             // aktueller Listeninhalt von notiz[] wird in neuer JSON Datei gespeichert
    notifyListeners();                                              // informiert alle Widgets, dass sich die Daten geändert haben
  }

  void aktualisierenNotiz(String id, String newText) {
    final foundIndex = notiz.indexWhere((item) => item.id == id);
    if (foundIndex != -1) {
      notiz[foundIndex].text = newText;
      speichereNotizen();
    } else {
      print('Notiz konnte nicht aktualisiert werden: ID $id nicht gefunden');
    }
    notifyListeners();
  }

  void hinzufuegenPapierkorb(String id) {
    final foundIndex = notiz.indexWhere((item) => item.id == id);
    if (foundIndex != -1) {
      zuletztgeloescht.add(notiz[foundIndex]);
      speicherePapierkorb();
    } else {
      print('Notiz konnte nicht Papierkorb hinzugefügt werden: ID $id nicht gefunden');
    }
  }


  void loeschenNotiz(String id) {
    hinzufuegenPapierkorb(id);                                      // zu löschende Notiz wird zuerst in Papierkorb übertragen
    // Notizen aus Liste "notiz" entfernen, bei denen isChecked true ist
    notiz.removeWhere((item) => item.id == id);
    //speicherePapierkorb();                                          // zum Löschen ausgewählte Notiz wird zuerst in Papierkorb übertragen
  }                                                                 // erst bei nächstem Notizenübersicht() Aufruf wird die Notiz aus notiz[] gelöscht


  void rueckgaengigPapierkorb(String id) {
    final foundIndex = zuletztgeloescht.indexWhere((item) => item.id == id);
    if (foundIndex != -1) {
      notiz.add(zuletztgeloescht[foundIndex]);
      speichereNotizen();
    } else {
      print('Notiz mit ID $id nicht gefunden');
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
      page = NotizenOderPapierkorb();                           //Notizenübersicht, Startseite
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