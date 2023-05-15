import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../main.dart';

//------------------------notiz.dart soll Builder für eine Notiz darstellen------------------------//

class PapierkorbModelBuilder extends StatefulWidget {
  final PapierkorbModel muell;                              // Funktionsdeklarierung
  const PapierkorbModelBuilder({                            // Konstruktor
    Key? key,
    required this.muell,
  }) : super(key: key);

  @override
  State<PapierkorbModelBuilder> createState() => _PapierkorbModBldState();
}

//-----------------------------------------------------------------------------------//

class _PapierkorbModBldState extends State<PapierkorbModelBuilder> {
  //braucht man nur, wenn man Notizentext ändern will
  bool _isChecked = true;                                             // in Papierkorbliste sind alle Notizen standardmäßig angekreuzt -> durchgestrichen, ausgegraut

  @override                                                           
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return _buildPapierkorb(appState);
  }

  Widget _buildPapierkorb(MyAppState appState) {
    return ListTile(
      leading: Checkbox(
        value: _isChecked,
        onChanged: (value) {
          setState(() {
            _isChecked = value ?? true;
            appState.rueckgaengigPapierkorb(widget.muell.id);
          });
        },
      ),
      title: Text(
        widget.muell.text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PapierkorbModel {  // Struktur zum Abspeichern im Array Notiz (MyAppState) mit id, text und isChecked
  final String id;
  late String text;

  PapierkorbModel({
    required this.id,
    required this.text,
  });

  factory PapierkorbModel.fromJson(Map<String, dynamic> json) {
    return PapierkorbModel(
      id: json['id'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}



