// To parse this JSON data, do
//
//     final bus = busFromJson(jsonString);

import 'dart:convert';

Bus busFromJson(String str, String id) => Bus.fromJson(json.decode(str), id);

String busToJson(Bus data) => json.encode(data.toJson());

class Bus {
    int capacity;
    String name;
    String type;
    String id;

    Bus({
        required this.capacity,
        required this.name,
        required this.type,
        required this.id,
    });

    factory Bus.fromJson(Map<String, dynamic> json, String id) => Bus(
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
