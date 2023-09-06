# BrainBox
Notizen-App, die in Zusammenhang mit einem Uniprojekt entstanden ist

# ÜBER DIE APP

Diese App wurde im Rahmen eines Uni-Projektes angelegt und programmiert.
Im Grunde ist es eine einfache Notizenapp, in der man neue Notizen anlegen und sie ebenfalls bearbeiten oder löschen kann. Es gab anfangs verschiedene Ideen, wie diese App umgesetzt werden könnte und welche Funktionen sie darüber hinaus beinhalten könnte. Ursprünglich sollte mit jeder neu erstellten Notiz eine neue Notizdatei generiert werden, die beim öffnen einen Arbeitsbereich bietet für bulletpoints, lange Texte oder Checklisten. Allerdings wurde dieser Ansatz im Laufe der Zeit verworfen auf Grund von Komplexität und Zeit.

Es gibt 2 Pages: eine Notizenübersicht und eine Papierkorbübersicht. In der Notizenübersicht befinden sich alle erstellten Notizen in chronologischer Reihenfolge ihrer Erstellung. Jede Notiz besitzt einen Bulletpoint,  einen Text (vom Nutzer vergeben) und einen Edit-Button. Wenn der Edit-Button gedrückt wurde, wird der Text zu einem Eingabefeld, das standardmäßig den Text der Notiz beinhaltet. Von hier aus kann man den Text bearbeiten. Der Edit-Button ist nun ein Speicher-Button und kann betätigt werden, wenn man seine Änderungen am Notizentext bestätigen möchte. Falls der Bulletpoint einer Notiz betätigt wird, wird die betreffende Notiz in den Papierkorb verschoben und verschwindet aus der Notizenübersicht. In der Papierkorbübersicht hat man dann die Möglichkeit, gelöschte Notizen durch betätigen der Bulletpoints wiederherzustellen oder alle Notizen permanent zu löschen.

Um eine neue Notiz anzulegen gibt es einen Floating Action Button in der rechten unteren Ecke der Notizenübersicht. Wenn dieser angetippt wird, öffnet sich ein PopUp Fenster mit einer Eingabezeile und den Optionen "Abbrechen" oder "Bestätigen". Ein Schließen des PopUps durch Klicken in den Außenbereich ist nicht möglich, um versehentliches Abbrechen der Eingabe zu verhindern. Ein leeres Eingabefeld wird nicht akzeptiert und durch eine rote Fehlermeldung markiert.

Als kleiner Zusatz wurde noch ein Fadeout am unteren Bildschirmrand eingefügt, um die Notizen nach unten hin verblassen zu lassen. Dies hat nur einen visuellen Effekt. Grundsätzlich fehlt bisher eine Sortier- oder Filterfunktion der Notizen in irgendeiner Form.

# NOCH AUSSTEHENDE ERWEITERUNGEN / FIXES:
## NÜTZLICH:

### Designprobleme:
- wenn sich Text über mehrere Zeilen erstreckt, dann könnte die Schriftgröße verkleinert werden um Platz zu sparen und übersichtlicher zu wirken
- "Neue Notiz"-Button über oberster Notiz als eigenes Zeilenelement, und wenn gerade nicht sichtbar, dann soll wieder rechts unten das Plus zu sehen sein
- Bulletpoints für Löschfunktionalität werden durch Swipebewegung von links nach rechts ersetzt, um Notizen in Papierkorb zu verschieben
- Notizen könnten (unabhängig von ihren Prioritäten) nach oben oder untern verschoben werden (Auswahl-Optionsmenü einrichten und Sidemarker rechts an den Notizen zum grabben und verschieben einblenden + Bulletpoints für weitere Optionen links; Bulletpoints: erst möglich, wenn Swipebewegung zum Löschen die bisherigen Bulletpoints abgelöst hat

### Funktionalitätsprobleme:
- Sortier- bzw. Filterfunktionen fehlen noch, erfordern weitere Notizattribute
- Notizen besitzen noch kein Zeitattribut
    -> wenn sie Zeitattribut besitzen kann man Erstellzeitpunkt mit einblenden
    -> Notizen können noch nicht nach Erstellzeitpunkt sortiert werden oder 
    nach Wiederherstellen aus Papierkorb an entsprechender Stelle einsortiert werden
    -> daraus resultierend: Sortierfunktion ("Neueste/Älteste zuerst")
    -> daraus resultierend: Filterfunktion ("alle Notizen, die ab 01. Januar erstellt wurden")
- gelöschte Notizen werden noch nicht nach bestimmten Zeitraum permanent aus Speicher gelöscht
- Notizen besitzen bisher noch keine Priotitäten
    -> Prioritätenattribut zu jeder Notiz
    -> daraus resultierend: Sortierfunktion ("Wichtige Notizen zuerst", "Absteigend nach Priorität")
    -> daraus resultierend: Filterfunktion ("Nur wichtige Notizen anzeigen")
- Querformatfunktionalität fehlt bisher -> Querformat funktioniert, allerdings rutscht NavBar noch nicht zur Seite und "Neue Notiz"-Popup löst Pixel Overflow beim Öffnen der Tastatur aus

## NICE TO HAVE:
- App-Widget noch default Flutter Icon
- Versionsnummer auf 1.0.0 anpassen
- disappear-Animation für gelöschte/wiederhergestellte Notizen, um visuell Feedback über Verbleib der Notiz zu geben
- mögliche Deadline Datumsangabe für eine Notiz, die man bei der Erstellung angeben kann
-> anschließend an diese Erweiterung könnte man eine Benachrichtigung in der Benachrichtigungsleiste anzeigen lassen, sobald die Deadline in einem bestimmten Zeitraum erreicht wird ("Fällig in 3 Tagen: Steuer einreichen!")

## Im Betrieb erkannte Leistungsprobleme:
- während man eine Notiz bearbeitet, kann der Floating Action Button betätigt werden, um eine neue Notiz anzulegen. Während der Bearbeitung einer Notiz sollte das nicht erlaubt sein
- andere Notizen können während des Bearbeitens einer Notiz noch gelöscht werden
- neue Notizen können während des Bearbeitens einer Notiz erstellt werden
- im Bearbeitungszustand: Notiz hat keinen Mindestabstand zur Tastatur/rutscht nicht auf Tastaturniveau hoch (wichtig für unteren Notizen)
- Papierkorb-Icon soll nicht angezeigt werden, wenn keine Notizen im Papierkorb sind 
- in seltenen Fällen kann es vorkommen, dass wenn eine Notiz nach mehrmaligem antippen des Bulletpoints erst in den Papierkorb verschoben wird, diese Notiz mehrmals in den Papierkorb verschoben wurde (praktisch Duplizierung einer einzelnen Notiz)
    -> mögliche Lösung: zum Löschen ausgewählte Notizen werden in Queue verschoben, die ca. 2 Sekunden nach dem die letzte Notiz gequeued wurde die Notizen gesammelt in den Papierkorb verschiebt. Fehler durch mehrmaliges inqueuen werden durch Queue Bedingungen abgefangen (wichtigste Bedingung: es dürfen keine Notizen mit der selben ID in die Queue verschoben werden). Positiver Nebeneffekt: ressourceneffizienter/weniger rechenintensiv durch weniger Dateiarbeit
- Bulletpoint Feld zum Löschen und Wiederherstellen der Notizen sollte vergrößert werden (nicht sichtbar), um ungenaue Tippeingaben abzufangen

# INSTALLATION DER APP
BrainBox wurde unter Windows 10 in MS Visual Studio Code programmiert in Verbindung mit Flutter Extensions und Android Studio. Folgen Sie der Installationsanleitung unter https://docs.flutter.dev/get-started/install. Nach dem alle Installationsschritte befolgt wurden, die SDK in VS Code eingebunden und das Repository geforkt wurde können sie die App im Emulator ausführen.

Zum Testen im Programmierbetrieb wurde ein Google Pixel 6 Pro mit Android 8.0 Oreo Emulator verwendet. Alle Android Version von 8.0 an aufwärts sollten definitiv kompatibel mit der App sein, darunter wurde nicht getestet.

Zur Installation der App auf einem physischen Gerät mit entsprechenden Eigenschaften folgen sie dieser Anleitung unter dem Punkt "Build an APK" und anschließend "Install an APK on a device":
https://docs.flutter.dev/deployment/android#building-the-app-for-release
Beachten Sie, dass der Developer Modus in den Android Einstellungen aktiviert werden muss inkl. USB Debugging, um die APK erfolgreich installieren zu können.
