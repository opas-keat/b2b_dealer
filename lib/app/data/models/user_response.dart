import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.id,
    required this.avatarUrl,
    required this.displayName,
  });

  String id;
  String avatarUrl;
  String displayName;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        avatarUrl: json["avatarUrl"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatarUrl": avatarUrl,
        "displayName": displayName,
      };

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        avatarUrl: json["avatarUrl"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "avatarUrl": avatarUrl,
        "displayName": displayName,
      };
}
