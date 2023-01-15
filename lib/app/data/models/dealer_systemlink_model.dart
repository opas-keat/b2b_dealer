import 'dart:convert';

class DealerSystemLinkRequest {
  DealerSystemLinkRequest({
    required this.criteria,
    required this.limit,
  });

  DealerSystemLinkCriteria criteria;
  int limit;

  factory DealerSystemLinkRequest.fromJson(Map<String, dynamic> json) =>
      DealerSystemLinkRequest(
        criteria: DealerSystemLinkCriteria.fromJson(json["criteria"]),
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "criteria": criteria.toJson(),
        "limit": limit,
      };
}

class DealerSystemLinkCriteria {
  DealerSystemLinkCriteria({
    required this.dealerCode,
  });

  String dealerCode;

  factory DealerSystemLinkCriteria.fromJson(Map<String, dynamic> json) =>
      DealerSystemLinkCriteria(
        dealerCode: json["dealer_code"],
      );

  Map<String, dynamic> toJson() => {
        "dealer_code": dealerCode,
      };
}

class DealerSystemLinkResponse {
  DealerSystemLinkResponse({
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  int statusCode;
  String code;
  String message;
  DealerSystemLinkList data;

  factory DealerSystemLinkResponse.fromJson(Map<String, dynamic> json) =>
      DealerSystemLinkResponse(
        statusCode: json["status_code"],
        code: json["code"],
        message: json["message"],
        data: DealerSystemLinkList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class DealerSystemLinkList {
  DealerSystemLinkList({
    required this.rows,
    required this.totalCount,
  });

  List<DealerSystemLink> rows;
  int totalCount;

  factory DealerSystemLinkList.fromJson(Map<String, dynamic> json) =>
      DealerSystemLinkList(
        rows: List<DealerSystemLink>.from(
            json["rows"].map((x) => DealerSystemLink.fromJson(x))),
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
        "total_count": totalCount,
      };
}

class DealerSystemLink {
  DealerSystemLink({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phone,
  });

  String id;
  String code;
  String name;
  String address;
  String phone;

  factory DealerSystemLink.fromJson(Map<String, dynamic> json) =>
      DealerSystemLink(
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

class DealerInsert {
  DealerInsert({
    required this.address,
    required this.dealerCode,
    required this.linkId,
    required this.name,
    required this.phone,
    required this.createdBy,
  });

  String address;
  String dealerCode;
  String linkId;
  String name;
  String phone;
  String createdBy;

  factory DealerInsert.fromJson(Map<String, dynamic> json) => DealerInsert(
        address: json["address"],
        dealerCode: json["dealer_code"],
        linkId: json["link_id"],
        name: json["name"],
        phone: json["phone"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "dealer_code": dealerCode,
        "link_id": linkId,
        "name": name,
        "phone": phone,
        "created_by": createdBy,
      };

  factory DealerInsert.fromMap(Map<String, dynamic> json) => DealerInsert(
        address: json["address"],
        dealerCode: json["dealer_code"],
        linkId: json["link_id"],
        name: json["name"],
        phone: json["phone"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "dealer_code": dealerCode,
        "link_id": linkId,
        "name": name,
        "phone": phone,
        "created_by": createdBy,
      };
}

class DealerResponseSubscription {
  DealerResponseSubscription({
    required this.id,
    required this.dealerCode,
    required this.linkId,
    required this.name,
    required this.address,
    required this.phone,
    required this.setDefault,
  });

  String id;
  String dealerCode;
  String linkId;
  String name;
  String address;
  String phone;
  bool setDefault;

  factory DealerResponseSubscription.fromMap(Map<String, dynamic> json) =>
      DealerResponseSubscription(
        id: json["id"],
        dealerCode: json["dealer_code"],
        linkId: json["link_id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        setDefault: json["set_default"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "dealer_code": dealerCode,
        "link_id": linkId,
        "name": name,
        "address": address,
        "phone": phone,
        "set_default": setDefault,
      };
}
