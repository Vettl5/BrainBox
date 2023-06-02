Noch ausstehende nötige Anpassungen:
DRINGEND:
- Code auskommentieren

NICHT SO DRINGEND:
- Notizenübersicht Fadeout unten, um keine harte Kante zu haben (DONE)
- kleinen Abstand zwischen erstem Listenelement und AppBar einfügen (DONE)
- wenn sich Text über mehrere Zeilen erstreckt, dann könnte die Schriftgröße verkleinert werden um Platz zu sparen
und übersichtlicher zu wirken
- es können mehrere Notizen gleichzeitig bearbeitet werden -> funktioniert zwar wegen ID's, aber nicht logisch (DONE)
- "Notiz erstellt" Alert kürzer machen und abhängig von nachfolgenden Alerts abbrechen (DONE, funktioniert aber bisher nur bei einer 
anderen Notiz. Wenn man verschiedene Notizen versucht zu bearbeiten wird der Alert nicht sofort wieder ausgeblendet)
(2 Notizen werden kurz nacheinander erstellt-> Alert der ersten Notiz soll für Alert der 2. Notiz verschwinden/Platz machen)
- Notizen besitzen noch kein Zeitattribut
-> wenn sie Zeitattribut besitzen kann man Erstellzeitpunkt mit einblenden
- gelöschte Notizen werden noch nicht nach bestimmten Zeitraum permanent aus Speicher gelöscht
- App noch nicht auf Handy ausprobiert
- Querformatfunktionalität fehlt bisher -> Querformat funktioniert, allerdings rutscht NavBar noch nicht zur Seite

WENN NOCH ZEIT IST:
- App-Widget noch default Flutter Icon
- Versionsnummer auf 1.0.0 anpassen

Übriggebliebene Erweiterungen:
- Notizen können noch nicht nach Erstellzeitpunkt sortiert werden oder 
nach Wiederherstellen aus Papierkorb an entsprechender Stelle einsortiert werden
- daraus resultierend: Sortierfunktion
- disappear-Animation für gelöschte/wiederhergestellte Notizen, um visuell Feedback über Verbleib der Notiz zu geben
- mögliche Deadline Datumsangabe für jede Notiz