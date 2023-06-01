// Struktur zum Abspeichern im Array Notiz (MyAppState) mit id, text und geloescht
class NotizModel {
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