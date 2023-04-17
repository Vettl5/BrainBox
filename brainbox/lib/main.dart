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
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];                   //Liste für gespeicherte Favoriten Wortpaare

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
      print('unliked');                          //Wenn Like Button gedrückt + Wort bereits in Liste => entfernen
    } else {
      favorites.add(current);
      print('liked');                             //sonst hinzufügen
    }
    notifyListeners();                            //Benachrichtigung an alle Widgets, die MyAppState nutzen
  }
}
 
class MyHomePage extends StatefulWidget {         //Widget von MyHomePage (quasi gesamter Bildschirm)
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
      page = GeneratorPage();
      break;
    case 1:
      page = FavoritesPage();
      break;
    default:
      throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Row(                                  //Reihe; enthält gesamte Appseite, Navbar+Generator
        children: [
          SafeArea(                               //Widget linke Seite, Navigation Bar, dass für Abstand zu Notch, Statusleiste etc. sorgt
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(        //Home Button
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(        //Favoriten Button
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,       //Index des ausgewählten Buttons, Start bei 0
              onDestinationSelected: (value) {    //Funktion, die ausgeführt wird, wenn Button gedrückt
                setState(() {                     //setState, damit Widget neu gebaut wird (quasi refresh, changeNotifyer)
                  selectedIndex = value;          //Index des ausgewählten Buttons auf Wert der Destination setzen}
                  print(value);                   //Konsolenausgabe, um zu sehen, ob Button erkannt wird
               });                                //Resultat: Klick auf Herz wird nicht nur erkannt sondern auch angezeigt
              },
            ), 
          ),
          Expanded(                                 //Widget rechte Seite, Generator Page (Expanded gibt Widget so viel Platz wie möglich)
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,                        //Variable page aufrufen als Inhalt; based on selectedIndex wird die entsprechende Seite aufgerufen
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {              //Zu jedem Widget gehört eine Build Funktion
    var appState = context.watch<MyAppState>();     //Variable appState mit Klasse MyAppState linken
    var pair = appState.current;                    //aktuelles Wort in pair speichern

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;                        //wenn akt. Begriff in Favoritenliste, dann ausgefülltes Herz
    } else {
      icon = Icons.favorite_border;                 //sonst leeres Herz
    }

    return Center(                                 //Zentrieren des Widgets (waagerechte)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  //Zentrieren der Spalte (senkrechte)

          children: [
            BigCard(pair: pair),                    //aktuelles Wort in Kleinbuchstaben ausgeben s.u.
            SizedBox(height: 20),                   //Abstandshalter zwischen Karte und Button
            
            Row(
              mainAxisSize: MainAxisSize.min,       //alle Elemente/Button zentrieren
              children: [
                ElevatedButton.icon(                //Icon-Button mit zusätzl. Text
                  onPressed: () {
                    appState.toggleFavorite();      //Wenn Button gedrückt Like-Funktion aufrufen
                  },
                  icon: Icon(icon),                 //Button Icon (s.o. Fkt. IconData icon)
                  label: Text('Like'),              //Button Text
                  ),
                 SizedBox(width: 15),               //Abstandshalter zwischen Buttons 
                ElevatedButton(                     //Normaler Button, um nächstes Wort zu generieren
                  onPressed: () {                   //Wenn Button gedrückt
                   appState.getNext();              //Neues Wort generieren durch getNext()
                  },
                child: Text('Next'),                //Button Text
                ),
              ]
            ),
          ],  //children
        ),
      );
  }
}

class BigCard extends StatelessWidget {             //Widget BigCard, gibt Wortpaar aus
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);                  //Pointer zu Theme der App (in MyApp festgelegt)
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary);          //Schriftart/-farbe der Karte

    return Card(
      color: theme.colorScheme.primary,             //Farbe der Karte, festgelegt in MyApp
      child: Padding(
        padding: const EdgeInsets.all(15),          //Außenabstand der Karte
        child: Text(pair.asLowerCase,               //Karte mit Wort füllen
        style: style,                               //Textfarbe/-schrift
        semanticsLabel: pair.asPascalCase,),        //Für Screenreader gedacht                   
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(                                //eine Spalte, die man scrollen kann
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'), //Anzahl der Favoriten
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}