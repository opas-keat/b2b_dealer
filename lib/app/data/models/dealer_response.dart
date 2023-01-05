import 'dart:convert';

DealerResponse dealerResponseFromJson(String str) =>
    DealerResponse.fromJson(json.decode(str));

String dealerResponseToJson(DealerResponse data) => json.encode(data.toJson());

class DealerResponse {
  DealerResponse({
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  int? statusCode;
  String? code;
  String? message;
  Dealer? data;

  DealerResponse.withError({
    this.statusCode,
    String? msg,
  })  : message = msg;

  factory DealerResponse.fromJson(Map<String, dynamic> json) => DealerResponse(
        statusCode: json["status_code"],
        code: json["code"],
        message: json["message"],
        data: Dealer.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "code": code,
        "message": message,
        "data": data,
      };
}

class Dealer {
  Dealer({
    this.id = '',
    this.code = '',
    this.name = '',
    this.address = '',
    this.phone = '',
  });

  String id;
  String code;
  String name;
  String address;
  String phone;

  factory Dealer.fromJson(Map<String, dynamic> json) => Dealer(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "address": address,
        "phone": phone,
      };
}
