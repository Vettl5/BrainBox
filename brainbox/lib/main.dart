import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { //Definiert einige Randdetails der App
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'BrainBox',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 92, 124, 182)),
        ),
        home: MyHomePage(),
        routes: {
          '/': (context) => MyHomePage(),
          '/bearbeiten': (context) => NotizBearbeiten(),
        },
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  late Directory appDocumentsDir; // Verzeichnis für App-Dokumente

  // Konstruktor
  MyAppState() {
    _initAppDir();
  }

  void _initAppDir() async {
    appDocumentsDir = await getApplicationDocumentsDirectory();
  }
}
 


class MyHomePage extends StatefulWidget {         //Widget von MyHomePage (quasi gesamter Bildschirm)
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {      //State Klasse für MyHomePage; Private Klasse, da nur in MyHomePage verwendet
  
  var selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    
    Widget page;
    switch (selectedIndex) {
    case 0:
      page = Notizen();                           //wird Notizen Seite, noch ungenutzt
      break;
    case 1:
      page = NeueNotiz();                         //wird Generator Seite, noch ungenutzt
      break;
    case 2:
      page = Placeholder();                       //wird Einstellungen Seite, noch ungenutzt
      break;
    default:
      throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Column(
        children: [
          SafeArea(                                 //Widget rechte Seite, Generator Page (Expanded gibt Widget so viel Platz wie möglich)
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,                          //Variable page aufrufen als Inhalt; based on selectedIndex wird die entsprechende Seite aufgerufen
            ),
          ),
          BottomAppBar(                             //Widget untere Seite, BottomAppBar mit BottomNavigationBar
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
                  selectedIndex = value;          
                  print(value);                   
                });                                
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Notizen extends StatelessWidget {
  const Notizen({super.key});
  @override
  Widget build(BuildContext context) {                              //Zu jedem Widget gehört eine Build Funktion
    var appState = context.watch<MyAppState>();                     //Variable appState mit Klasse MyAppState linken
    //var pair = appState.current;                                  //aktuelles Wort in pair speichern

    return ListView(                                                //eine Spalte, die man scrollen kann
      children: [
        for (var file in appState.appDocumentsDir.listSync())       //für jedes File in appDocumentsDir
          ListTile(
            title: Text(file.path),                                 //Titel des ListTiles ist der Pfad des Files
            onTap: () {
              openAndEditFile(context, file as File);
            },
          ),  
      ],
    );
  }
}


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


/*class NeueNotiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(                                 //Zentrieren des Widgets (waagerechte)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  //Zentrieren der Spalte (senkrechte)

          children: [
            Text('Neue Notizen hier hin', style: Theme.of(context).textTheme.displayMedium),
            Text('Hier sollen neue Notizen erstellt werden können, die dann in der Notizen Seite angezeigt werden'),
          ],  //children
        ),
      );
    
  }
}*/

class NeueNotiz extends StatefulWidget {
  const NeueNotiz({super.key});
  @override
  State<NeueNotiz> createState() => _NeueNotizState();
}

class _NeueNotizState extends State<NeueNotiz> {
  final _formKey = GlobalKey<FormState>(); // Key für Formulareingaben
  final TextEditingController _nameController = TextEditingController();
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {  // Wenn alle Formulareingaben gültig sind
      final name = _nameController.text;
      if (name.isNotEmpty) { // Wenn ein Name für die Notiz eingegeben wurde
        // Datei mit dem eingegebenen Namen erstellen
        var appState = context.watch<MyAppState>();
        final file = File('${appState.appDocumentsDir.path}/$name.txt');
        file.createSync();

        // Neue Datei öffnen und bearbeiten
        openAndEditFile(context, file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Erstellen'),
          ),  //ElevatedButton
        ],  //children
      ),  //Column
    ); //Center
  } //Widget build
} //_NeueNotizState


/*class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(                                 //Zentrieren des Widgets (waagerechte)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  //Zentrieren der Spalte (senkrechte)

          children: [
            Text('Einstellungen', style: Theme.of(context).textTheme.displayMedium),
            Text('Hier werden deine Notizen angezeigt'),
          ],  //children
        ),
      );
    
  }
}*/