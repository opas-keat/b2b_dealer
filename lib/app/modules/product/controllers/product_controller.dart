import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart';

import '../../../data/graphql/graphql_product.dart';
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

  // minusItem() {
  //   if (itemCount.value < 1) {
  //     itemCount.value = 0;
  //   } else {
  //     itemCount.value--;
  //   }
  //   update();
  // }

  addItemToCart() {
    cartTotalItem.value++;
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
        'listBrandAndModel:: currentCategory: ' + currentCategory.value);
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
