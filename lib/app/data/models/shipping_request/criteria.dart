import 'package:collection/collection.dart';

class ShippingRequestCriteria {
  String? name = '';
  String? centralRegion = '0';
  String? theNorthEastRegion = '0';
  String? northRegion = '0';
  String? westRegion = '0';
  String? southernRegion = '0';
  String? eastRegion = '0';
  String? bkkRegion = '0';

  ShippingRequestCriteria({
    this.name,
    this.centralRegion,
    this.theNorthEastRegion,
    this.northRegion,
    this.westRegion,
    this.southernRegion,
    this.eastRegion,
    this.bkkRegion,
  });

  factory ShippingRequestCriteria.fromJson(Map<String, dynamic> json) =>
      ShippingRequestCriteria(
        name: json['name'] as String?,
        centralRegion: json['centralRegion'] as String?,
        theNorthEastRegion: json['theNorthEastRegion'] as String?,
        northRegion: json['northRegion'] as String?,
        westRegion: json['westRegion'] as String?,
        southernRegion: json['southernRegion'] as String?,
        eastRegion: json['eastRegion'] as String?,
        bkkRegion: json['bkkRegion'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'centralRegion': centralRegion,
        'theNorthEastRegion': theNorthEastRegion,
        'northRegion': northRegion,
        'westRegion': westRegion,
        'southernRegion': southernRegion,
        'eastRegion': eastRegion,
        'bkkRegion': bkkRegion,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ShippingRequestCriteria) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      centralRegion.hashCode ^
      theNorthEastRegion.hashCode ^
      northRegion.hashCode ^
      westRegion.hashCode ^
      southernRegion.hashCode ^
      eastRegion.hashCode ^
      bkkRegion.hashCode;
}
