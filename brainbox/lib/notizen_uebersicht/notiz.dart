import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

//------------------------notiz.dart soll Builder für eine Notiz darstellen------------------------//

class Notiz extends StatefulWidget {
  final NotizModel notiz;                             //Deklarierung von NotizModel; der Variable notiz die Funktion zuordnen
  final Function(NotizModel) onNotizChecked;
  final Function(NotizModel) onNotizEdited;

  const Notiz({
    Key? key,
    required this.notiz,
    required this.onNotizChecked,
    required this.onNotizEdited,
  }) : super(key: key);

  @override
  State<Notiz> createState() => _NotizState();
}

class _NotizState extends State<Notiz> {
  bool _isEditing = false;
  TextEditingController _controller = TextEditingController();

  @override                                                           
  void initState() {
    super.initState();
    _controller.text = widget.notiz.text;
  }

  @override                                                           
  Widget build(BuildContext context) {
    return _isEditing ? _buildEditing() : _buildNotEditing();
  }

  Widget _buildNotEditing() {
    return ListTile(
      leading: Checkbox(
        value: widget.notiz.isChecked,
        onChanged: (value) {
          setState(() {
            widget.notiz.isChecked = value!;
            widget.onNotizChecked(widget.notiz);
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
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
    );
  }

  Widget _buildEditing() {                             
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.delete),                         
        onPressed: () {
          widget.onNotizDeleted(widget.notiz);
        },
      ),
      title: TextField(
        controller: _controller,
        autofocus: true,
        onSubmitted: (value) {
          setState(() {
            widget.notiz.text = value;
            widget.onNotizChanged(widget.notiz);
            _isEditing = false;
          });
        },
      ),
    );
  }
}

class NotizModel {
  var uuid = Uuid();                  //Vergabe einer eindeutigen ID, um identische Notizen zu ermöglichen
  String text;                        //Notiztext
  bool isChecked;                     //Checkbox, die Notiz entweder als erledigt oder nicht erledigt markiert    

  NotizModel({
    required this.uuid,
    required this.text,
    this.isChecked = false,
  });
}



