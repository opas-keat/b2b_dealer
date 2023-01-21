import 'package:collection/collection.dart';

import 'criteria.dart';

class ShippingRequestModel {
  ShippingRequestCriteria? criteria;
  int? limit;
  int? offset;

  ShippingRequestModel({this.criteria, this.limit, this.offset});

  factory ShippingRequestModel.fromJson(Map<String, dynamic> json) {
    return ShippingRequestModel(
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
    if (other is! ShippingRequestModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => criteria.hashCode ^ limit.hashCode ^ offset.hashCode;
}
