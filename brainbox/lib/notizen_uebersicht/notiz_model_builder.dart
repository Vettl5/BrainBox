import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../main.dart';

//------------------------notiz.dart soll Builder für eine Notiz darstellen------------------------//

class NotizModelBuilder extends StatefulWidget {
  final NotizModel notiz;                           //Funktionsdefinition für json Dateieigenschaften (diese Attribute braucht jede Notiz)
  const NotizModelBuilder({                         //Konstruktor, erwartet bei jedem Aufruf alle Parameter von notiz (also bei jedem Aufruf von NotizenUebersicht)
    Key? key,
    required this.notiz,
  }) : super(key: key);

  @override
  State<NotizModelBuilder> createState() => _NotizModBldState();
}

//-----------------------------------------------------------------------------------//

class _NotizModBldState extends State<NotizModelBuilder> {
  //braucht man nur, wenn man Notizentext ändern will
  bool _isEditing = false;
  TextEditingController _controller = TextEditingController();

  // Anzeigetext der Notiz eig. TextEditingController mit Notiztext als Default; Bearbeitungsmöglichkeit!
  @override                                                           
  void initState() {
    super.initState();
    _controller.text = widget.notiz.text;
  }

  @override                                                           
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return _isEditing ? _buildEditing(appState) : _buildNotEditing(appState);
  }

  Widget _buildNotEditing(MyAppState appState) {

    TextStyle textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    if (widget.notiz.geloescht) {
      textStyle = textStyle.copyWith(
        decoration: TextDecoration.lineThrough,
        color: Colors.grey,
      );
    }

    return ListTile(
      leading: Checkbox(
        value: widget.notiz.geloescht,
        onChanged: (value) {
          setState(() {
            widget.notiz.geloescht = value ?? false;
            appState.loeschenNotiz(widget.notiz.id);
          });
        },
      ),
      title: Text(
        widget.notiz.text,
        style: textStyle,
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          setState(() {
            _isEditing = true;
          });
        },
      ),
    );
  }

  Widget _buildEditing(MyAppState appState) {
  return ListTile(
    title: TextFormField(
      controller: _controller,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    trailing: IconButton(
      icon: Icon(Icons.save),
      onPressed: () {
        setState(() {
          widget.notiz.text = _controller.text;
          _isEditing = false;
          appState.aendereNotiz(widget.notiz.id, widget.notiz.text);
        });
      },
    ),
  );
}
}

class NotizModel {  // Struktur zum Abspeichern im Array Notiz (MyAppState) mit id, text und isChecked
  final String id;
  late String text;
  bool geloescht;

  NotizModel({
    required this.id,
    required this.text,
    this.geloescht = false,
  });

  factory NotizModel.fromJson(Map<String, dynamic> json) {
    return NotizModel(
      id: json['id'],
      text: json['text'],
      geloescht: json['geloescht'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'geloescht': geloescht,
    };
  }
}