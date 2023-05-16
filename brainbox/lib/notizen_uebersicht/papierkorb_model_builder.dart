import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../notizen_uebersicht/notiz_model_builder.dart';
import '../main.dart';

//------------------------notiz.dart soll Builder für eine Notiz darstellen------------------------//

class PapierkorbElementBuilder extends StatefulWidget {
  final id = 
  final notiz = NotizModel();
  const PapierkorbElementBuilder({
    Key? key,
    required this.notiz,
  }) : super(key: key);

  @override
  State<PapierkorbElementBuilder> createState() => _PapierkorbElementBuilderState();
}

//-----------------------------------------------------------------------------------//

class _PapierkorbElementBuilderState extends State<PapierkorbElementBuilder> {
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
            appState.wiederherstellenAusPapierkorb(widget.muell.id);
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



