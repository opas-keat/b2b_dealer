import 'dart:convert';

class ShippingResponseSubscription {
  ShippingResponseSubscription({
    required this.id,
    required this.linkedId,
    required this.name,
  });

  final String id;
  final String linkedId;
  final String name;

  factory ShippingResponseSubscription.fromMap(Map<String, dynamic> json) =>
      ShippingResponseSubscription(
        id: json["id"],
        linkedId: json["linked_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "linked_id": linkedId,
        "name": name,
      };
}
