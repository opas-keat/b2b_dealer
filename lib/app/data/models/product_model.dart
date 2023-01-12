import 'dart:convert';

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
