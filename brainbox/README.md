Diese App wurde im Rahmen eines Uni-Projektes angelegt und programmiert.
Im Grunde ist es eine einfache Notizenapp, in der man neue Notizen anlegen kann und sie ebenfalls bearbeiten oder löschen kann. Es gab anfangs verschiedene Ideen, wie diese App umgesetzt werden könnte und welche Funktionen sie darüber hinaus beinhalten könnte. Ursprünglich sollte mit jeder neu erstellten Notiz eine neue Notizdatei generiert werden, die beim öffnen einen Arbeitsbereich bietet für bulletpoints, lange Texte oder Checklisten. Allerdings wurde dieser Ansatz im Laufe der Zeit verworfen auf Grund von Komplexität und Zeit.

Es gibt 2 Pages: die Notizenübersicht und eine Papierkorbübersicht. In der Notizenübersicht befinden sich alle erstellten Notizen in chronologischer Reihenfolge ihrer Erstellung. Jede Notiz besitzt einen Bulletpoint,  einen Text (vom Nutzer vergeben) und einen Edit-Button. Wenn der Edit-Button gedrückt wurde, wird der Text zu einem Eingabefeld, das standardmäßig den Text der Notiz beinhaltet. Von hier aus kann man den Text bearbeiten. Der Edit-Button ist nun ein Speicher-Button und kann betätigt werden, wenn man seine Änderungen am Notizentext bestätigen möchte. Falls der Bulletpoint einer Notiz betätigt wird, wird die betreffende Notiz in den Papierkorb verschoben und verschwindet aus der Notizenübersicht. In der Papierkorbübersicht hat man dann die Möglichkeit, gelöschte Notizen durch betätigen der Bulletpoints wiederherzustellen oder alle Notizen permanent zu löschen.

Um eine neue Notiz anzulegen gibt es einen Floating Action Button in der rechten unteren Ecke der Notizenübersicht. Wenn dieser angetippt wird, öffnet sich ein PopUp Fenster mit einer Eingabezeile und den Optionen "Abbrechen" oder "Bestätigen". Ein Schließen des PopUps durch Klicken in den Außenbereich ist nicht möglich, um versehentliches Abbrechen der Eingabe zu verhindern. Ein leeres Eingabefeld wird nicht akzeptiert und durch eine rote Fehlermeldung markiert.

Als kleiner Zusatz wurde noch ein Fadeout am unteren Bildschirmrand eingefügt, um die Notizen nach unten hin verblassen zu lassen. Dies hat nur einen visuellen Effekt. Grundsätzlich fehlt bisher eine Sortier- oder Filterfunktion der Notizen in irgendeiner Form.

NOCH AUSSTEHENDE ERWEITERUNGEN:
NÜTZLICH:
- wenn sich Text über mehrere Zeilen erstreckt, dann könnte die Schriftgröße verkleinert werden um Platz zu sparen und übersichtlicher zu wirken
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

NICE TO HAVE:
- App-Widget noch default Flutter Icon
- Versionsnummer auf 1.0.0 anpassen
- disappear-Animation für gelöschte/wiederhergestellte Notizen, um visuell Feedback über Verbleib der Notiz zu geben
- mögliche Deadline Datumsangabe für eine Notiz, die man bei der Erstellung angeben kann
-> anschließend an diese Erweiterung könnte man eine Benachrichtigung in der Benachrichtigungsleiste anzeigen lassen, sobald die Deadline in einem bestimmten Zeitraum erreicht wird ("Fällig in 3 Tagen: Steuer einreichen!")
