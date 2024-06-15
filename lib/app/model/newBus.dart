// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final Newbus = NewbusFromJson(jsonString);

import 'dart:convert';

NewBus newbusFromJson(String str, String id) => NewBus.fromJson(json.decode(str), id);

String newbusToJson(NewBus data) => json.encode(data.toJson());

class NewBus {
    int capacity;
    String name;
    String type;
    String id;

    NewBus({
        required this.capacity,
        required this.name,
        required this.type,
        required this.id,
    });

    factory NewBus.fromJson(Map<String, dynamic> json, String id) => NewBus(
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
