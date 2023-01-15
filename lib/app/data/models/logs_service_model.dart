import 'dart:convert';

class LogsServiceModel {
  LogsServiceModel({
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  int statusCode;
  String code;
  String message;
  LogsListResponse data;

  factory LogsServiceModel.fromMap(Map<String, dynamic> json) =>
      LogsServiceModel(
        statusCode: json["status_code"],
        code: json["code"],
        message: json["message"],
        data: LogsListResponse.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "code": code,
        "message": message,
        "data": data.toMap(),
      };
}

class LogsListResponse {
  LogsListResponse({
    required this.rows,
    required this.totalCount,
  });

  List<LogsList> rows;
  int totalCount;

  factory LogsListResponse.fromMap(Map<String, dynamic> json) =>
      LogsListResponse(
        rows: List<LogsList>.from(json["rows"].map((x) => LogsList.fromMap(x))),
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toMap() => {
        "rows": List<dynamic>.from(rows.map((x) => x.toMap())),
        "total_count": totalCount,
      };
}

class LogsList {
  LogsList({
    required this.id,
    required this.detail,
    required this.createdAt,
    required this.createdBy,
  });

  String id;
  String detail;
  DateTime createdAt;
  String createdBy;

  factory LogsList.fromMap(Map<String, dynamic> json) => LogsList(
        id: json["id"],
        detail: json["detail"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "detail": detail,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
      };
}

class LogsCreateRequestModel {
  LogsCreateRequestModel({
    required this.createdBy,
    required this.detail,
  });

  String createdBy;
  String detail;

  factory LogsCreateRequestModel.fromMap(Map<String, dynamic> json) =>
      LogsCreateRequestModel(
        createdBy: json["created_by"],
        detail: json["detail"],
      );

  Map<String, dynamic> toMap() => {
        "created_by": createdBy,
        "detail": detail,
      };

  factory LogsCreateRequestModel.fromJson(Map<String, dynamic> json) =>
      LogsCreateRequestModel(
        createdBy: json["created_by"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "created_by": createdBy,
        "detail": detail,
      };
}

class LogsCreateResponseModel {
  LogsCreateResponseModel({
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  int? statusCode;
  String? code;
  String? message;
  LogsCreateResponse? data;

  LogsCreateResponseModel.withError({
    this.statusCode,
    String? msg,
  }) : message = msg;

  factory LogsCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      LogsCreateResponseModel(
        statusCode: json["status_code"],
        code: json["code"],
        message: json["message"],
        data: LogsCreateResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "code": code,
        "message": message,
        "data": data,
      };
}

class LogsCreateResponse {
  LogsCreateResponse({
    required this.id,
    required this.detail,
    required this.createdAt,
    required this.createdBy,
  });

  String id;
  String detail;
  DateTime createdAt;
  String createdBy;

  factory LogsCreateResponse.fromJson(Map<String, dynamic> json) =>
      LogsCreateResponse(
        id: json["id"],
        detail: json["detail"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "detail": detail,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
      };

  factory LogsCreateResponse.fromMap(Map<String, dynamic> json) =>
      LogsCreateResponse(
        id: json["id"],
        detail: json["detail"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "detail": detail,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
      };
}
