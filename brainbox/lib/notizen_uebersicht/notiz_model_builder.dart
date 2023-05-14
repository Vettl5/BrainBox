import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../main.dart';

//------------------------notiz.dart soll Builder für eine Notiz darstellen------------------------//

class Notiz extends StatefulWidget {
  final NotizModel notiz;

  const Notiz({
    Key? key,
    required this.notiz,
  }) : super(key: key);

  @override
  State<Notiz> createState() => _NotizState();
}

//-----------------------------------------------------------------------------------//

class _NotizState extends State<Notiz> {
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
    return ListTile(
      leading: Checkbox(
        value: widget.notiz.isChecked,
        onChanged: (value) {
          setState(() {
            widget.notiz.isChecked = value ?? false;
            appState.loeschenNotiz(widget.notiz.id);
          });
        },
      ),
      title: Text(
        widget.notiz.text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
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
          appState.aktualisierenNotiz(widget.notiz.id, widget.notiz.text);
        });
      },
    ),
  );
}
}

class NotizModel {
  final String id;
  late String text;
  bool isChecked;

  NotizModel({
    required this.id,
    required this.text,
    this.isChecked = false,
  });

  factory NotizModel.fromJson(Map<String, dynamic> json) {
    return NotizModel(
      id: json['id'],
      text: json['text'],
      isChecked: json['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isChecked': isChecked,
    };
  }
}



