import 'dart:convert';

class ShippingInsert {
  String? createdBy;
  String? linkedId;
  String? name;

  ShippingInsert({this.createdBy, this.linkedId, this.name});

  factory ShippingInsert.fromJson(Map<String, dynamic> json) => ShippingInsert(
        createdBy: json["created_by"],
        linkedId: json["linked_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "created_by": createdBy,
        "linked_id": linkedId,
        "name": name,
      };
}
