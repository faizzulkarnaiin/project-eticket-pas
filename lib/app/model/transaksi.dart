// To parse this JSON data, do
//
//     final transkaksi = transkaksiFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Transkaksi transkaksiFromJson(String str, String id) =>
    Transkaksi.fromJson(json.decode(str), id);

String transkaksiToJson(Transkaksi data) => json.encode(data.toJson());

class Transkaksi {
  String jadwalBusId;
  String nama;
  String paymentMethodId;
  int price;
  bool isScanned;
  String transactionId;
  String userId;
  String id;

  Transkaksi({
    required this.jadwalBusId,
    required this.nama,
    required this.paymentMethodId,
    required this.price,
    required this.isScanned,
    required this.transactionId,
    required this.userId,
    required this.id,
  });

  factory Transkaksi.fromJson(Map<String, dynamic> json, String id) =>
      Transkaksi(
          jadwalBusId: (json["jadwalBusId"] as DocumentReference).id,
          nama: json["nama"],
          paymentMethodId: (json["paymentMethodId"] as DocumentReference).id,
          price: json["price"],
          isScanned: json["isScanned"],
          transactionId: json["transactionId"],
          userId: json["userId"],
          id: id);

  Map<String, dynamic> toJson() => {
        "jadwalBusId": jadwalBusId,
        "nama": nama,
        "paymentMethodId": paymentMethodId,
        "price": price,
        "isScanned": isScanned,
        "transactionId": transactionId,
        "userId": userId,
        "id": id
      };
}
