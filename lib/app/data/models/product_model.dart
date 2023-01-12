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
