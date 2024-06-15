import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

DiscountModel discountModelFromJson(String str, String id) =>
    DiscountModel.fromJson(json.decode(str), id);

String paymentMethodToJson(DiscountModel data) => json.encode(data.toJson());

class DiscountModel {
  String? id;
  double discountPercentage;
  String? type;
  // String value;
  String metodePembayaranId; // Bidang untuk menyimpan ID metode pembayaran
  String jadwalBusId; // Bidang untuk menyimpan ID jadwal bus

  DiscountModel({
    required this.id,
    required this.discountPercentage,
    required this.type,
    // required this.value,
    required this.metodePembayaranId,
    required this.jadwalBusId,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json, String id) =>
      DiscountModel(
        id: json["id"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        type: json["type"],
        metodePembayaranId:
            (json["metodePembayaranId"] as DocumentReference).id,
        jadwalBusId: (json["jadwalBusId"] as DocumentReference).id,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discountPercentage": discountPercentage,
        "type": type,
        "metodePembayaranId": metodePembayaranId,
        "jadwalBusId": jadwalBusId
      };
}
