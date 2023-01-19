import 'data.dart';

class ShippingResponse {
  int? statusCode;
  String? code;
  String? message;
  Data? data;

  ShippingResponse({
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  factory ShippingResponse.fromJson(Map<String, dynamic> json) {
    return ShippingResponse(
      statusCode: json['status_code'] as int?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'code': code,
        'message': message,
        'data': data?.toJson(),
      };
}
