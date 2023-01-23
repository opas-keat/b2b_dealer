class ShippingModel {
  String? id;
  String? code;
  String? name;
  String? phone;
  String? mobile;
  String? note;
  String? linkedId;

  ShippingModel(
      {this.id,
      this.code,
      this.name,
      this.phone,
      this.mobile,
      this.note,
      this.linkedId});

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        id: json['id'] as String?,
        code: json['code'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        mobile: json['mobile'] as String?,
        note: json['note'] as String?,
        linkedId: json['linked_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'phone': phone,
        'mobile': mobile,
        'note': note,
        'linked_id': linkedId,
      };
}
