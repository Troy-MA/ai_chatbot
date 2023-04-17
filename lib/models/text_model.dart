import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TextModel {
  final String text;
  final bool isSender;
  final Timestamp time;

  TextModel({
    required this.text,
    required this.isSender,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isSender': isSender,
      'time': time,
    };
  }

  factory TextModel.fromMap(Map<String, dynamic> map) {
    return TextModel(
      text: map['text'] ?? '',
      isSender: map['isSender'] ?? false,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TextModel.fromJson(String source) =>
      TextModel.fromMap(json.decode(source));
}
