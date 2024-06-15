// ignore_for_file: file_names

import 'dart:convert';

DsikonKriteria dsikonKriteriaFromJson(String str) =>
    DsikonKriteria.fromJson(json.decode(str));

String dsikonKriteriaToJson(DsikonKriteria data) => json.encode(data.toJson());

class DsikonKriteria {
  String? id;
  String discountId;
  String type;
  dynamic value; // Bisa berupa nilai langsung atau DocumentReference

  DsikonKriteria({
    this.id,
    required this.discountId,
    required this.type,
    required this.value,
  });

  factory DsikonKriteria.fromJson(Map<String, dynamic> json) => DsikonKriteria(
        id: json["id"],
        discountId: json["discountId"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discountId": discountId,
        "type": type,
        "value": value,
      };
}
