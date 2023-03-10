import 'shipping_model.dart';

class Data {
  List<ShippingModel>? rows;
  int? totalCount;

  Data({this.rows, this.totalCount});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => ShippingModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount: json['total_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'rows': rows?.map((e) => e.toJson()).toList(),
        'total_count': totalCount,
      };
}
