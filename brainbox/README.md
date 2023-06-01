Noch ausstehende nötige Anpassungen:
DRINGEND:
- .dart Dateien müssen noch in ihrer Ordnerstruktur angepasst werden
- PIXEL OVERFLOW bei zu vielen Notizen
- daraus resultierend: wenn eine Datei bearbeitet werden soll, die zu weit unten auf dem Bildschirm angezeigt wird,
dann rutscht die zu bearbeitende Notiz nicht auf Höhe überhalb der Tastatur sondern wird durch die Tastatur überlappt
- wenn Notiz zum bearbeiten ausgewählt wird, dann öffnet sich zwar die Bearbeitungszeile, allerdings noch nicht die Tastatur
- Notizen in der "Gelöschte Notizen" Übersicht sind standardmäßig angeticked (ändern oder nicht?)
- Code auskommentieren

NICHT SO DRINGEND:
- "Papierkorb leeren" Funktion
- Trennstriche zwischen den Notizen^
- "Notiz erstellt" Alert kürzer machen und abhängig von nachfolgenden Alerts abbrechen
(2 Notizen werden kurz nacheinander erstellt-> Alert der ersten Notiz soll für Alert der 2. Notiz verschwinden/Platz machen)
- Notizen besitzen noch kein Zeitattribut
- gelöschte Notizen werden noch nicht nach bestimmten Zeitraum permanent aus Speicher gelöscht
- App noch nicht auf Handy ausprobiert
- Querformatfunktionalität fehlt bisher

WENN NOCH ZEIT IST:
- Notizen können noch nicht nach Erstellzeitpunkt sortiert werden oder 
nach Wiederherstellen aus Papierkorb an entsprechender Stelle einsortiert werden
- daraus resultierend: Sortierfunktion
- App-Widget noch default Flutter Icon
- Versionsnummer auf 1.0.0 anpassen

════════ Exception caught by rendering library ═════════════════════════════════
The following assertion was thrown during layout:
A RenderFlex overflowed by 145 pixels on the bottom.

The relevant error-causing widget was
Column
papierkorb_uebersicht.dart:33
You can inspect this widget using the 'Inspect Widget' button in the VS Code notification.
The overflowing RenderFlex has an orientation of Axis.vertical.
The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern. This is usually caused by the contents being too big for the RenderFlex.

Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit within the available space instead of being sized to their natural size.
This is considered an error condition because it indicates that there is content that cannot be seen. If the content is legitimately bigger than the available space, consider clipping it with a ClipRect widget before putting it in the flex, or using a scrollable container rather than a Flex, like a ListView.

The specific RenderFlex in question is: RenderFlex#f9a66 relayoutBoundary=up9 OVERFLOWING
════════════════════════════════════════════════════════════════════════════════