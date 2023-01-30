import 'package:b2b_dealer/app/modules/cart/controllers/cart_controller.dart';
import 'package:b2b_dealer/app/modules/product/views/search_tires.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart';

import '../../../data/graphql/graphql_product.dart';
import '../../../data/models/cart_order.dart';
import '../../../data/models/product_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils/log_util.dart';

class ProductController extends GetxController {
  final logTitle = "ProductController";
  var isLoading = true.obs;
  RxString currentCategory = "1".obs;
  final bamsList = <BrandAndModel>[].obs;
  final productsList = <ProductsModel>[].obs;
  final product = ProductModel().obs;
  final imageUrl = <String>[].obs;

  final currentBrand = "".obs;
  final currentModel = "".obs;

  final currentName = "".obs;

  // cart
  RxInt cartTotalItem = 0.obs;
  CartController cartController = Get.put(CartController());

  // itemCount
  // RxInt itemsCount = 0.obs;
  final offset = 0.obs;
  final limit = 50.obs;

  final graphqlClient = createNhostGraphQLClient(nhostClient);

  @override
  void onInit() {
    listBrandAndModel();
    // showProductDetail("", "", "", 0);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  SearchProductTires(
    String brand,
    String size,
    String year,
    String speedIndex,
    String loadIndex,
    String pattern,
  ) async {
    isLoading(true);
    bamsList.value.clear();
    productsList.value.clear();
    try {
      final whereField = WhereField();
      if (brand.isNotEmpty) {
        whereField.brand = FiledRegex(sRegex: brand);
      }
      if (size.isNotEmpty) {
        whereField.matSize = FiledRegex(sRegex: size);
      }
      if (year.isNotEmpty) {
        whereField.year = FiledEqual(sEq: year);
      }
      if (speedIndex.isNotEmpty) {
        whereField.speedIndex = FiledEqual(sEq: speedIndex);
      }
      if (loadIndex.isNotEmpty) {
        whereField.loadIndex = FiledEqual(sEq: loadIndex);
      }
      if (pattern.isNotEmpty) {
        whereField.treadWare = FiledEqual(sEq: pattern);
      }
      whereField.groupCode = GroupCode(lIn: groupTires);
      Log.loga(
          logTitle, 'searchProductWheel:: whereField: ${whereField.toJson()}');

      var result = await graphqlClient.query(
        QueryOptions(
          document: searchProduct,
          variables: {
            'where1': whereField.toJson(),
          },
        ),
      );
      if (result.hasException) {
        Log.loga(
            logTitle, 'searchProductWheel::hasException: ${result.exception}');
      }
      final response = (result.data!['products'] as List)
          .map((e) => ProductsResponseModel.fromMap(e))
          .toList();
      for (var i = 0; i < response.length; i++) {
        final url = await getImageUrl(response[i].productFiles.first.fileId);

        productsList.value.add(ProductsModel(
          id: response[i].id,
          name: response[i].name,
          price: response[i].price,
          url: url,
        ));
      }
      update();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Log.loga(logTitle, 'SearchProductTires:: $e');
    }
    Log.loga(logTitle, 'SearchProductTires:: end');
  }

  searchProductWheel(
    String brand,
    String size,
    String pcd,
    String color,
    String priceBegin,
    String priceEnd,
  ) async {
    Log.loga(logTitle, 'searchProductWheel:: start');
    Log.loga(logTitle, 'searchProductWheel:: brand: $brand');
    Log.loga(logTitle, 'searchProductWheel:: size: $size');
    Log.loga(logTitle, 'searchProductWheel:: pcd: $pcd');
    Log.loga(logTitle, 'searchProductWheel:: color: $color');
    Log.loga(logTitle, 'searchProductWheel:: priceBegin: $priceBegin');
    Log.loga(logTitle, 'searchProductWheel:: priceEnd: $priceEnd');
    isLoading(true);
    bamsList.value.clear();
    productsList.value.clear();
    try {
      final whereField = WhereField();
      if (brand.isNotEmpty) {
        whereField.brand = FiledRegex(sRegex: brand);
      }
      if (size.isNotEmpty) {
        whereField.matSize = FiledRegex(sRegex: size);
      }
      if (pcd.isNotEmpty) {
        whereField.pitchCircleCode = FiledRegex(sRegex: pcd);
      }
      if (color.isNotEmpty) {
        whereField.color = FiledRegex(sRegex: color);
      }
      if (priceBegin.isNotEmpty && priceEnd.isEmpty) {
        whereField.price = PriceRange(
          iGte: int.parse(priceBegin),
          iLte: 999999,
        );
      } else if (priceBegin.isEmpty && priceEnd.isNotEmpty) {
        whereField.price = PriceRange(
          iGte: 0,
          iLte: int.parse(priceEnd),
        );
      } else if (priceBegin.isNotEmpty && priceEnd.isNotEmpty) {
        whereField.price = PriceRange(
          iGte: int.parse(priceBegin),
          iLte: int.parse(priceEnd),
        );
      }
      whereField.groupCode = GroupCode(lIn: groupWheel);
      Log.loga(
          logTitle, 'searchProductWheel:: whereField: ${whereField.toJson()}');

      var result = await graphqlClient.query(
        QueryOptions(
          document: searchProduct,
          variables: {
            'where1': whereField.toJson(),
          },
        ),
      );
      if (result.hasException) {
        Log.loga(
            logTitle, 'searchProductWheel::hasException: ${result.exception}');
      }
      final response = (result.data!['products'] as List)
          .map((e) => ProductsResponseModel.fromMap(e))
          .toList();
      for (var i = 0; i < response.length; i++) {
        final url = await getImageUrl(response[i].productFiles.first.fileId);

        productsList.value.add(ProductsModel(
          id: response[i].id,
          name: response[i].name,
          price: response[i].price,
          url: url,
        ));
      }
      update();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Log.loga(logTitle, 'searchProductWheel:: $e');
    }
    Log.loga(logTitle, 'searchProductWheel:: end');
  }

  // minusItem() {
  //   if (itemCount.value < 1) {
  //     itemCount.value = 0;
  //   } else {
  //     itemCount.value--;
  //   }
  //   update();
  // }

  addItemToCart(ProductModel product) {
    Log.loga(logTitle, 'addItemToCart:: start');
    Log.loga(logTitle, 'addItemToCart:: product: ${product.name}');
    cartTotalItem.value++;
    //  sampleCartOrders.forEach((element) {
    //   cartOrders.value.add(CartOrder(
    //     fNMSysProdId: element.fNMSysProdId,
    //     fTProdCode: element.fTProdCode,
    //     fTProdNameTH: element.fTProdNameTH,
    //     fNDealerPrice1: element.fNDealerPrice1,
    //     priceCredit: element.priceCredit,
    //     fNPrice: element.fNPrice,
    //     fNQuantityBal: element.fNQuantityBal,
    //     quantity: element.quantity,
    //   ));
    // });
    cartController.cartOrders.value.add(CartOrder(
      fNMSysProdId: product.linkId,
      fTProdCode: product.code,
      fTProdNameTH: product.name,
      fNDealerPrice1: product.dealerPrice1,
      // priceCredit: element.priceCredit,
      fNPrice: product.price,
      // fNQuantityBal: product.fNQuantityBal,
      quantity: 1,
    ));
    update();
  }

  showProductDetail(
    String productId,
    String productName,
    String url,
    int price,
  ) async {
    Log.loga(logTitle, 'showProductDetail:: start');
    Log.loga(logTitle, 'showProductDetail:: productId: $productId');
    Log.loga(logTitle, 'showProductDetail:: productName: $productName');
    Log.loga(logTitle, 'showProductDetail:: url: $url');
    Log.loga(logTitle, 'showProductDetail:: price: $price');
    Log.loga(logTitle, 'showProductDetail:: brand: ${currentBrand.value}');
    Log.loga(logTitle, 'showProductDetail:: model: ${currentModel.value}');

    isLoading(true);
    try {
      productsList.value.clear();
      currentName.value = productName;
      // productId = "a96d83bb-2abe-44d7-82e1-6f4964043bb5";
      var result = await graphqlClient.query(
        QueryOptions(
          document: getProductDetail,
          variables: {
            'id': productId,
          },
        ),
      );
      if (result.hasException) {
        Log.loga(logTitle, 'showProductDetail:: ${result.exception}');
      }
      // Log.loga(logTitle, 'showProductDetail:: ${result}');
      final response = (result.data!['products'] as List)
          .map((e) => ProductResponseModel.fromMap(e))
          .toList();
      // for (var i = 0; i < response.length; i++) {
      //   Log.loga(logTitle, 'showProductDetail:: ${response[i].name}');
      // }
      product.value = (ProductModel(
        brand: response.first.brand,
        code: response.first.code,
        color: response.first.color,
        dealerPrice1: response.first.dealerPrice1,
        groupCode: response.first.groupCode,
        id: response.first.id,
        linkId: response.first.linkId,
        matSize: response.first.matSize,
        model: response.first.model,
        name: productName,
        offset: response.first.offset,
        pitchCircleCode: response.first.pitchCircleCode,
        price: price,
        treadWare: response.first.treadWare,
        width: response.first.width,
        url: url,
      ));
      update();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Log.loga(logTitle, 'showProductDetail:: $e');
    }
    Log.loga(logTitle, 'showProductDetail:: end');
  }

  refreshToHome() {
    currentBrand.value = "";
    currentModel.value = "";
    bamsList.value.clear();
    productsList.value.clear();
    update();
    listBrandAndModel();
  }

  getImageUrl(String fileId) async {
    final resultUrl = await nhostClient.storage.getPresignedUrl(fileId);
    return resultUrl.url.toString();
  }

  listProduct(String brand, String model) async {
    Log.loga(logTitle, 'listProduct:: start');
    Log.loga(logTitle, 'listProduct:: brand: $brand');
    Log.loga(logTitle, 'listProduct:: model $model');
    isLoading(true);
    bamsList.value.clear();
    productsList.value.clear();
    currentBrand.value = brand;
    currentModel.value = model;
    try {
      if (brand.isNotEmpty && model.isNotEmpty) {
        var result = await graphqlClient.query(
          QueryOptions(
            document: listProductByBrandAndModelQuery,
            variables: {
              'brand': brand,
              "model": model,
            },
          ),
        );
        if (result.hasException) {
          Log.loga(logTitle, 'listProduct:: ${result.exception}');
        }
        final response = (result.data!['products'] as List)
            .map((e) => ProductsResponseModel.fromMap(e))
            .toList();
        for (var i = 0; i < response.length; i++) {
          final url = await getImageUrl(response[i].productFiles.first.fileId);

          productsList.value.add(ProductsModel(
            id: response[i].id,
            name: response[i].name,
            price: response[i].price,
            url: url,
          ));
        }
      }
      update();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Log.loga(logTitle, 'listProduct:: $e');
    }
    Log.loga(logTitle, 'listProduct:: end');
  }

  listBrandAndModel() async {
    Log.loga(logTitle, 'listBrandAndModel:: start');
    Log.loga(logTitle,
        'listBrandAndModel:: currentCategory: ${currentCategory.value}');
    isLoading(true);
    bamsList.value.clear();
    try {
      var result = await graphqlClient.query(
        QueryOptions(
          document: listBrandAndModelQuery,
          variables: {
            'brand': (currentCategory.value == '1') ? brandWheel : brandTires,
            "group": (currentCategory.value == '1') ? groupWheel : groupTires,
          },
        ),
      );
      if (result.hasException) {
        Log.loga(logTitle, 'listBrandAndModel:: ${result.exception}');
      }
      final response = (result.data!['products'] as List)
          .map((e) => BrandAndModelResponseQuery.fromMap(e))
          .toList();
      for (var i = 0; i < response.length; i++) {
        final url = await getImageUrl(response[i].productFiles.first.fileId);

        bamsList.value.add(BrandAndModel(
          id: response[i].id,
          brand: response[i].brand,
          model: response[i].model,
          url: url,
        ));
      }
      update();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Log.loga(logTitle, 'listBrandAndModel:: $e');
    }
    Log.loga(logTitle, 'listBrandAndModel:: end');
  }
}
