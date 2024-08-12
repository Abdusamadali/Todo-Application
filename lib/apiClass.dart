

// To parse this JSON data, do
//
//     final samplemodel = samplemodelFromJson(jsonString);

import 'dart:convert';

List<Samplemodel> samplemodelFromJson(String str) => List<Samplemodel>.from(json.decode(str).map((x) => Samplemodel.fromJson(x)));

String samplemodelToJson(List<Samplemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Samplemodel {
  int userId;
  int id;
  String title;
  String body;

  Samplemodel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Samplemodel.fromJson(Map<String, dynamic> json) => Samplemodel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
