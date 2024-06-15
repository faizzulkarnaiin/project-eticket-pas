// To parse this JSON data, do
//
//     final Oldbus = OldbusFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

OldBus oldbusFromJson(String str, String id) => OldBus.fromJson(json.decode(str), id);

String oldbusToJson(OldBus data) => json.encode(data.toJson());

class OldBus {
    int capacity;
    String name;
    String type;
    String id;

    OldBus({
        required this.capacity,
        required this.name,
        required this.type,
        required this.id,
    });

    factory OldBus.fromJson(Map<String, dynamic> json, String id) => OldBus(
        capacity: json["capacity"],
        name: json["name"],
        type: json["type"],
        id:  id
    );

    Map<String, dynamic> toJson() => {
        "capacity": capacity,
        "name": name,
        "type": type,
        "id": id,
    };
}
