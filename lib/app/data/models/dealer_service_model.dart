import 'dart:convert';

DealerServiceResponse dealerResponseFromJson(String str) =>
    DealerServiceResponse.fromJson(json.decode(str));

String dealerResponseToJson(DealerServiceResponse data) =>
    json.encode(data.toJson());

class DealerServiceResponse {
  DealerServiceResponse({
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  int? statusCode;
  String? code;
  String? message;
  DealerService? data;

  DealerServiceResponse.withError({
    this.statusCode,
    String? msg,
  }) : message = msg;

  factory DealerServiceResponse.fromJson(Map<String, dynamic> json) =>
      DealerServiceResponse(
        statusCode: json["status_code"],
        code: json["code"],
        message: json["message"],
        data: DealerService.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "code": code,
        "message": message,
        "data": data,
      };
}

class DealerService {
  DealerService({
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

  factory DealerService.fromJson(Map<String, dynamic> json) => DealerService(
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

class DealersResponse {
  DealersResponse({
    required this.dealerCode,
    required this.name,
  });

  String dealerCode;
  String name;

  factory DealersResponse.fromMap(Map<String, dynamic> json) => DealersResponse(
        dealerCode: json["dealer_code"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "dealer_code": dealerCode,
        "name": name,
      };
}
