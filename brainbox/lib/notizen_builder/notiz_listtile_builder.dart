import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../main.dart';
import 'notiz_model_builder.dart';

class NotizListTileBuilder extends StatefulWidget {
  //final NotizModel notiz;                           //Funktionsdefinition für json Dateieigenschaften (diese Attribute braucht jede Notiz)
  final String id;
  final String text;
  final bool geloescht;
  
  NotizListTileBuilder({                         /* Konstruktor, erwartet bei jedem Aufruf alle Parameter der zu ladenden Notiz (also bei 
                                                 jedem Aufruf von NotizenUebersicht oder PapierkorbUebersicht)*/
    Key? key,
    required this.id,
    required this.text,
    required this.geloescht,
  }) : super(key: key);

  @override
  State<NotizListTileBuilder> createState() => _NotizListTileBuilderState();
}

//-----------------------------------------------------------------------------------//

class _NotizListTileBuilderState extends State<NotizListTileBuilder> {
  //braucht man nur, wenn man Notizentext ändern will
  bool _isEditing = false;
  TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  

  // Anzeigetext der Notiz eig. TextEditingController mit Notiztext als Default; Bearbeitungsmöglichkeit!
  @override                                                           
  void initState() {
    super.initState();
    _controller.text = widget.text;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override                                                           
  Widget build(BuildContext context) {
    
    var appState = context.watch<MyAppState>();
    return widget.geloescht == true 
      ? _buildPapierkorbListTile(appState) 
      : _isEditing == true
        ? _buildEditingListTile(appState)  
        : _buildNotEditingListTile(appState);
  }


/*-------------------------------------------------WIDGET FÜR PAPIERKORB-LISTTILE-------------------------------------------------*/
  Widget _buildPapierkorbListTile(MyAppState appState) {
  return ListTile(
    leading: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
      ),
      child: Checkbox(
        value: widget.geloescht,
        onChanged: (value) {
          setState(() {
            final foundIndex = appState.zuletztgeloescht.indexWhere((item) => item.id == widget.id);
            if (foundIndex != -1) {
              final updatedNotiz = NotizModel(
                id: appState.zuletztgeloescht[foundIndex].id,
                text: appState.zuletztgeloescht[foundIndex].text,
                geloescht: value!,
              );
              appState.zuletztgeloescht[foundIndex] = updatedNotiz;
              appState.wiederherstellenAusPapierkorb(widget.id);
            }
          });
        },
        shape: CircleBorder(),
        fillColor: MaterialStateColor.resolveWith((states) {
          return Colors.blue;
        }),
        checkColor: Colors.white,
      ),
    ),
    title: Text(
      widget.text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}


/*-------------------------------------------------WIDGETS FÜR NOTIZEN-LISTTILES-------------------------------------------------*/
/*-----------------------------------------------------Notiz im Anzeige Modus-----------------------------------------------------*/
  Widget _buildNotEditingListTile(MyAppState appState) {
  return ListTile(
    leading: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
      ),
      child: Checkbox(
        value: widget.geloescht,
        onChanged: (value) {
          setState(() {
            final foundIndex = appState.notiz.indexWhere((item) => item.id == widget.id);
            if (foundIndex != -1) {
              final updatedNotiz = NotizModel(
                id: widget.id,
                text: widget.text,
                geloescht: true,
              );
              appState.notiz[foundIndex] = updatedNotiz;
            }
            appState.verschiebenInPapierkorb(widget.id);
          });
        },
        shape: CircleBorder(),
        fillColor: MaterialStateColor.resolveWith((states) {
          return Colors.blue;
        }),
        checkColor: Colors.white,
      ),
    ),
    title: Text(
      widget.text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    trailing: IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        if (appState.editingCounter == 0) {
          appState.editingCounter = 1;
          setState(() {
            _isEditing = true;
            _focusNode.requestFocus();
          });
          }
        else {
          _isEditing = false;
          appState.snackbarMessenger(context, 'Es kann nur eine Notiz gleichzeitig bearbeitet werden!');
        }
      },

    ),
  );
}



/*-----------------------------------------------------Notiz im Bearbeiten Modus-----------------------------------------------------*/
  Widget _buildEditingListTile(MyAppState appState) {
    
    return ListTile(
      onTap: () {
        _focusNode.requestFocus(); // Fokus auf das Textfeld setzen
      },
      title: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          setState(() {
            // Suche das NotizModel-Objekt in notiz anhand der ID
            final foundIndex = appState.notiz                  // Listenelement aus notiz in Variable foundIndex speichern, dass widget.index entspricht
                .indexWhere((item) => item.id == widget.id);
            
            if (foundIndex != -1) {                                       // Wenn das NotizModel-Objekt gefunden wurde, führe folgendes aus:
              // Erstelle ein neues NotizModel-Objekt mit aktualisiertem geloescht-Wert und speichere es in updatedNotiz
              final updatedNotiz = NotizModel(
                id: widget.id,
                text: _controller.text,
                geloescht: widget.geloescht,
              );

              // Ersetze das NotizModel-Objekt in notiz mit dem aktualisierten Objekt
              appState.notiz[foundIndex] = updatedNotiz;
            }
            _isEditing = false;
            appState.editingCounter = 0;
            appState.speichereNotizen();
          });
        },
      ),
    );
  }
}