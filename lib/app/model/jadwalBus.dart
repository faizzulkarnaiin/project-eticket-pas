// ignore_for_file: file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

JadwalBus jadwalBusFromJson(String str, String id) => JadwalBus.fromJson(jsonDecode(str) as Map<String, dynamic>, id);

// Menggunakan jsonEncode untuk mengonversi Map<String, dynamic> ke String
String jadwalBusToJson(JadwalBus data) => jsonEncode(data.toJson());

class JadwalBus {
  String busId;
  int harga;
  String jadwalBerangkat;
  String tujuan;
  String id;

  JadwalBus({
    required this.busId,
    required this.harga,
    required this.jadwalBerangkat,
    required this.tujuan,
    required this.id,
  });

  factory JadwalBus.fromJson(Map<String, dynamic> json, String id) {
    return JadwalBus(
      busId: (json["busId"] as DocumentReference).id,
      harga: json["harga"] ,
      jadwalBerangkat: json["jadwal_berangkat"],
      tujuan: json["tujuan"],
      id: id,
    );
  }

  Map<String, dynamic> toJson() => {
    "busId": busId,
    "harga": harga,
    "jadwal_berangkat": jadwalBerangkat,
    "tujuan": tujuan,
    "id": id,
  };
}
