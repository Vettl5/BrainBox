import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';                       // für UI

import 'notizen_uebersicht/notizen_uebersicht.dart';
import 'notizen_uebersicht/papierkorb_uebersicht.dart';

class NotizenOderPapierkorb extends StatefulWidget {
  const NotizenOderPapierkorb ({super.key});
  @override
  State<NotizenOderPapierkorb> createState() => _NotizenOderPapierkorbState();
}

class _NotizenOderPapierkorbState extends State<NotizenOderPapierkorb> {
  var widgetIndex = 0;

  void buildNotizenOderPapierkorb(int index) {
    setState(() {
      widgetIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widgetIndex == 0
        ? NotizenUebersicht(onToggleIndex: buildNotizenOderPapierkorb)
        : PapierkorbUebersicht(onToggleIndex: buildNotizenOderPapierkorb);
  }
}