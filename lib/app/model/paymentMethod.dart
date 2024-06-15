// To parse this JSON data, do
//
//     final paymentMethod = paymentMethodFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PaymentMethod paymentMethodFromJson(String str, String id) =>
    PaymentMethod.fromJson(json.decode(str), id);

String paymentMethodToJson(PaymentMethod data) => json.encode(data.toJson());

class PaymentMethod {
  String nama;
  String id;

  PaymentMethod({
    required this.nama,
    required this.id,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json, String id) =>
      PaymentMethod(nama: json["nama"], id: id);

  Map<String, dynamic> toJson() => {"nama": nama, "id": id};
}
