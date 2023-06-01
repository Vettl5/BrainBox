Noch ausstehende nötige Anpassungen:
DRINGEND:
- .dart Dateien müssen noch in ihrer Ordnerstruktur angepasst werden (DONE)
- PIXEL OVERFLOW bei zu vielen Notizen Notizenübersicht (DONE)
- daraus resultierend: wenn eine Datei bearbeitet werden soll, die zu weit unten auf dem Bildschirm angezeigt wird,
dann rutscht die zu bearbeitende Notiz nicht auf Höhe überhalb der Tastatur sondern wird durch die Tastatur überlappt (DONE)
- PIXEL OVERFLOW bei zu vielen Notizen Papierkorbübersicht (DONE)
- wenn Notiz zum bearbeiten ausgewählt wird, dann öffnet sich zwar die Bearbeitungszeile, 
allerdings noch nicht die Tastatur (DONE)
- Notizen in der "Gelöschte Notizen" Übersicht sind standardmäßig angeticked (ändern oder nicht?)
-> beibehalten, nützlich für "Papierkorb leeren" Funktionalität -> umsetzen (inkl. Umgestaltung NavBar) (DONE)
-> "Neue Notiz"-Icon in rechter unterer Ecke über NavBar (erfordert Whitespace unter der letzten Notiz, um Bearbeiten-Icon nicht zu überdecken),
verbundenes "Neue Notiz"-PopUp statt eigene Seite, delete-AppBar-Icon in Papierkorb_Uebersicht (um alle Notizen endgültig zu löschen) (DONE)
- auskommentierten Code und ungebrauchte Dateien entfernen (DONE)
- Code auskommentieren

NICHT SO DRINGEND:
- über BottomNavBar ist ein weißer Balken -> der muss weg (DONE)
- kleinen Abstand zwischen erstem Listenelement und AppBar einfügen
- Trennstriche zwischen den Notizen (DONE)
- wenn sich Text über mehrere Zeilen erstreckt, dann könnte die Schriftgröße verkleinert werden um Platz zu sparen
und übersichtlicher zu wirken
- es können mehrere Notizen gleichzeitig bearbeitet werden -> funktioniert zwar wegen ID's, aber nicht logisch
- "Notiz erstellt" Alert kürzer machen und abhängig von nachfolgenden Alerts abbrechen
(2 Notizen werden kurz nacheinander erstellt-> Alert der ersten Notiz soll für Alert der 2. Notiz verschwinden/Platz machen)
- Notizen besitzen noch kein Zeitattribut
-> wenn sie Zeitattribut besitzen kann man Erstellzeitpunkt mit einblenden
- mögliche Deadline Datumsangabe für jede Notiz
- gelöschte Notizen werden noch nicht nach bestimmten Zeitraum permanent aus Speicher gelöscht
- App noch nicht auf Handy ausprobiert
- Querformatfunktionalität fehlt bisher -> Querformat funktioniert, allerdings rutscht NavBar noch nicht zur Seite

WENN NOCH ZEIT IST:
- Notizenübersicht Fadeout oben und unten, um keine harte Kante zu haben
- Notizen können noch nicht nach Erstellzeitpunkt sortiert werden oder 
nach Wiederherstellen aus Papierkorb an entsprechender Stelle einsortiert werden
- daraus resultierend: Sortierfunktion
- disappear Animation wenn Notizen gelöscht/wiederhergestellt werden
- App-Widget noch default Flutter Icon
- Versionsnummer auf 1.0.0 anpassen

Übriggebliebene Erweiterungen:
