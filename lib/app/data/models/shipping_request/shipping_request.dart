import 'package:collection/collection.dart';

import 'criteria.dart';

class ShippingRequest {
  ShippingRequestCriteria? criteria;
  int? limit;
  int? offset;

  ShippingRequest({this.criteria, this.limit, this.offset});

  factory ShippingRequest.fromJson(Map<String, dynamic> json) {
    return ShippingRequest(
      criteria: json['criteria'] == null
          ? null
          : ShippingRequestCriteria.fromJson(
              json['criteria'] as Map<String, dynamic>),
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'criteria': criteria?.toJson(),
        'limit': limit,
        'offset': offset,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ShippingRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => criteria.hashCode ^ limit.hashCode ^ offset.hashCode;
}
