import 'dart:convert';

ProductModel productModelFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  ProductModel({
    this.color = "",
    this.matSize = "",
    this.offset = "",
    this.pitchCircleCode = "",
    this.price = 0,
    this.treadWare = "",
    this.width = "",
    this.code = "",
    this.brand = "",
    this.dealerPrice1 = 0,
    this.groupCode = "",
    this.id = "",
    this.linkId = "",
    this.model = "",
    this.name = "",
    this.url = "",
  });

  String color;
  String matSize;
  String offset;
  String pitchCircleCode;
  int price;
  String treadWare;
  String width;
  String code;
  String brand;
  int dealerPrice1;
  String groupCode;
  String id;
  String linkId;
  String model;
  String name;
  String url;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        color: json["color"],
        matSize: json["mat_size"],
        offset: json["offset"],
        pitchCircleCode: json["pitch_circle_code"],
        price: json["price"],
        treadWare: json["tread_ware"],
        width: json["width"],
        code: json["code"],
        brand: json["brand"],
        dealerPrice1: json["dealer_price_1"],
        groupCode: json["group_code"],
        id: json["id"],
        linkId: json["link_id"],
        model: json["model"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "color": color,
        "mat_size": matSize,
        "offset": offset,
        "pitch_circle_code": pitchCircleCode,
        "price": price,
        "tread_ware": treadWare,
        "width": width,
        "code": code,
        "brand": brand,
        "dealer_price_1": dealerPrice1,
        "group_code": groupCode,
        "id": id,
        "link_id": linkId,
        "model": model,
        "name": name,
        "url": url,
      };
}

ProductResponseModel productResponseModelFromMap(String str) =>
    ProductResponseModel.fromMap(json.decode(str));

String productResponseModelToMap(ProductResponseModel data) =>
    json.encode(data.toMap());

class ProductResponseModel {
  ProductResponseModel({
    required this.id,
    required this.brand,
    required this.color,
    required this.code,
    required this.dealerPrice1,
    required this.groupCode,
    required this.linkId,
    required this.model,
    required this.name,
    required this.offset,
    required this.pitchCircleCode,
    required this.price,
    required this.treadWare,
    required this.width,
    required this.matSize,
    required this.loadIndex,
    required this.speedIndex,
    required this.year,
    required this.week,
  });

  String id;
  String brand;
  String color;
  String code;
  int dealerPrice1;
  String groupCode;
  String linkId;
  String model;
  String name;
  String offset;
  String pitchCircleCode;
  int price;
  String treadWare;
  String width;
  String matSize;
  String loadIndex;
  String speedIndex;
  String year;
  String week;

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        id: json["id"],
        brand: json["brand"],
        color: json["color"],
        code: json["code"],
        dealerPrice1: json["dealer_price_1"],
        groupCode: json["group_code"],
        linkId: json["link_id"],
        model: json["model"],
        name: json["name"],
        offset: json["offset"],
        pitchCircleCode: json["pitch_circle_code"],
        price: json["price"],
        treadWare: json["tread_ware"],
        width: json["width"],
        matSize: json["mat_size"],
        loadIndex: json["load_index"],
        speedIndex: json["speed_index"],
        year: json["year"],
        week: json["week"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "brand": brand,
        "color": color,
        "code": code,
        "dealer_price_1": dealerPrice1,
        "group_code": groupCode,
        "link_id": linkId,
        "model": model,
        "name": name,
        "offset": offset,
        "pitch_circle_code": pitchCircleCode,
        "price": price,
        "tread_ware": treadWare,
        "width": width,
        "mat_size": matSize,
        "load_index": loadIndex,
        "speed_index": speedIndex,
        "year": year,
        "week": week,
      };
}

ProductsModel productsModelFromMap(String str) =>
    ProductsModel.fromMap(json.decode(str));

String productsModelToMap(ProductsModel data) => json.encode(data.toMap());

class ProductsModel {
  ProductsModel({
    required this.id,
    required this.price,
    required this.name,
    required this.url,
  });

  String id;
  int price;
  String name;
  String url;

  factory ProductsModel.fromMap(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "name": name,
        "url": url,
      };
}

ProductsResponseModel productsResponseModelFromMap(String str) =>
    ProductsResponseModel.fromMap(json.decode(str));

String productsResponseModelToMap(ProductsResponseModel data) =>
    json.encode(data.toMap());

class ProductsResponseModel {
  ProductsResponseModel({
    required this.id,
    required this.price,
    required this.name,
    required this.productFiles,
  });

  String id;
  int price;
  String name;
  List<ProductFile> productFiles;

  factory ProductsResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductsResponseModel(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        productFiles: List<ProductFile>.from(
            json["product_files"].map((x) => ProductFile.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "name": name,
        "product_files": List<dynamic>.from(productFiles.map((x) => x.toMap())),
      };
}

BrandAndModelResponseQuery productsSubscriptionFromMap(String str) =>
    BrandAndModelResponseQuery.fromMap(json.decode(str));

String productsSubscriptionToMap(BrandAndModelResponseQuery data) =>
    json.encode(data.toMap());

class BrandAndModelResponseQuery {
  BrandAndModelResponseQuery({
    required this.id,
    required this.brand,
    required this.model,
    required this.productFiles,
  });

  String id;
  String brand;
  String model;
  List<ProductFile> productFiles;

  factory BrandAndModelResponseQuery.fromMap(Map<String, dynamic> json) =>
      BrandAndModelResponseQuery(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        productFiles: List<ProductFile>.from(
            json["product_files"].map((x) => ProductFile.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "brand": brand,
        "model": model,
        "product_files": List<dynamic>.from(productFiles.map((x) => x.toMap())),
      };
}

class ProductFile {
  ProductFile({
    required this.fileId,
  });

  String fileId;

  factory ProductFile.fromMap(Map<String, dynamic> json) => ProductFile(
        fileId: json["file_id"],
      );

  Map<String, dynamic> toMap() => {
        "file_id": fileId,
      };
}

class BrandAndModel {
  BrandAndModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.url,
  });

  String id;
  String brand;
  String model;
  String url;

  factory BrandAndModel.fromMap(Map<String, dynamic> json) => BrandAndModel(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "brand": brand,
        "model": model,
        "url": url,
      };
}

//wheel Brand, size, PCD, offset, colour, rate price
//tire brand, size (width, ratio, diameter), dot(ปีและเดือนที่ผลิต), speed index, load index, pattern(ดอกยาง)
class WhereField {
  FiledRegex? brand;
  FiledRegex? model;
  FiledRegex? matSize;
  FiledRegex? pitchCircleCode;
  FiledRegex? offset;
  FiledRegex? color;
  PriceRange? price;
  FiledEqual? year;
  FiledEqual? week;
  FiledEqual? speedIndex;
  FiledEqual? loadIndex;
  FiledEqual? treadWare;
  FiledEqual? width;
  GroupCode? groupCode;

  // WhereField({this.brand, this.model});

  // WhereField.fromJson(Map<String, dynamic> json) {
  //   brand = json['brand'] != null ? FiledRegex.fromJson(json['brand']) : null;
  //   model = json['model'] != null ? FiledRegex.fromJson(json['model']) : null;
  //   matSize =
  //       json['mat_size'] != null ? FiledRegex.fromJson(json['mat_size']) : null;
  //   pitchCircleCode = json['pitch_circle_code'] != null
  //       ? FiledRegex.fromJson(json['pitch_circle_code'])
  //       : null;
  //   offset =
  //       json['offset'] != null ? FiledRegex.fromJson(json['offset']) : null;
  //   color = json['color'] != null ? FiledRegex.fromJson(json['color']) : null;
  //   priceBegin =
  //       json['price'] != null ? FiledGTE.fromJson(json['price']) : null;
  //   priceEnd = json['price'] != null ? FiledLTE.fromJson(json['price']) : null;
  //   year = json['year'] != null ? FiledEqual.fromJson(json['year']) : null;
  //   week = json['week'] != null ? FiledEqual.fromJson(json['week']) : null;
  //   speedIndex = json['speed_index'] != null
  //       ? FiledEqual.fromJson(json['speed_index'])
  //       : null;
  //   loadIndex = json['load_index'] != null
  //       ? FiledEqual.fromJson(json['load_index'])
  //       : null;
  //   treadWare = json['tread_ware'] != null
  //       ? FiledEqual.fromJson(json['tread_ware'])
  //       : null;
  //   width = json['width'] != null ? FiledEqual.fromJson(json['width']) : null;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (matSize != null) {
      data['mat_size'] = matSize!.toJson();
    }
    if (pitchCircleCode != null) {
      data['pitch_circle_code'] = pitchCircleCode!.toJson();
    }
    if (offset != null) {
      data['offset'] = offset!.toJson();
    }
    if (color != null) {
      data['color'] = color!.toJson();
    }
    if (price != null) {
      data['price'] = price!.toJson();
    }
    if (year != null) {
      data['year'] = year!.toJson();
    }
    if (week != null) {
      data['week'] = week!.toJson();
    }
    if (speedIndex != null) {
      data['speed_index'] = speedIndex!.toJson();
    }
    if (loadIndex != null) {
      data['load_index'] = loadIndex!.toJson();
    }
    if (treadWare != null) {
      data['tread_ware'] = treadWare!.toJson();
    }
    if (width != null) {
      data['width'] = width!.toJson();
    }
    if (groupCode != null) {
      data['group_code'] = groupCode!.toJson();
    }
    return data;
  }
}

class PriceRange {
  int? iGte;
  int? iLte;

  PriceRange({this.iGte, this.iLte});

  PriceRange.fromJson(Map<String, dynamic> json) {
    iGte = json['_gte'];
    iLte = json['_lte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_gte'] = iGte;
    data['_lte'] = iLte;
    return data;
  }
}

class GroupCode {
  List<String>? lIn;

  GroupCode({this.lIn});

  GroupCode.fromJson(Map<String, dynamic> json) {
    lIn = json['_in'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_in'] = this.lIn;
    return data;
  }
}

class FiledEqual {
  String? sEq;

  FiledEqual({this.sEq});

  FiledEqual.fromJson(Map<String, dynamic> json) {
    sEq = json['_eq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_eq'] = sEq;
    return data;
  }
}

class FiledLike {
  String? sLike;

  FiledLike({this.sLike});

  FiledLike.fromJson(Map<String, dynamic> json) {
    sLike = json['_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_like'] = sLike;
    return data;
  }
}

class FiledRegex {
  String? sRegex;

  FiledRegex({this.sRegex});

  FiledRegex.fromJson(Map<String, dynamic> json) {
    sRegex = json['_iregex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_iregex'] = sRegex;
    return data;
  }
}

// class FiledGTE {
//   int? sGte;

//   FiledGTE({this.sGte});

//   FiledGTE.fromJson(Map<String, dynamic> json) {
//     sGte = json['_gte'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_gte'] = sGte;
//     return data;
//   }
// }

// class FiledLTE {
//   int? sLte;

//   FiledLTE({this.sLte});

//   FiledLTE.fromJson(Map<String, dynamic> json) {
//     sLte = json['_lte'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_lte'] = sLte;
//     return data;
//   }
// }

// class FiledRegex {
//   String? sRegex;

//   FiledRegex({this.sRegex});

//   FiledRegex.fromJson(Map<String, dynamic> json) {
//     sRegex = json['_iregex'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_iregex'] = sRegex;
//     return data;
//   }
// }

// class FiledRegex {
//   String? sRegex;

//   FiledRegex({this.sRegex});

//   FiledRegex.fromJson(Map<String, dynamic> json) {
//     sRegex = json['_iregex'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_iregex'] = sRegex;
//     return data;
//   }
// }
