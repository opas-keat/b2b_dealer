import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart';

import '../../../data/graphql/graphql_product.dart';
import '../../../data/models/product_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils/log_util.dart';

final logTitle = "ProductController";

class ProductController extends GetxController {
  var isLoading = true.obs;
  RxString currentCategory = "1".obs;
  final bamsList = <BrandAndModel>[].obs;
  final productsList = <ProductsModel>[].obs;
  final imageUrl = <String>[].obs;

  final currentBrand = "".obs;
  final currentModel = "".obs;

  final currentName = "".obs;

  // cart
  RxInt cartTotalItem = 0.obs;

  final graphqlClient = createNhostGraphQLClient(nhostClient);

  @override
  void onInit() {
    listBrandAndModel();
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

  showProductDetail(
    String productId,
    String productName,
    String url,
    int price,
  ) {
    Log.loga(logTitle, 'showProductDetail:: start');
    Log.loga(logTitle, 'listProduct:: productId: $productId');
    Log.loga(logTitle, 'listProduct:: productName: $productName');
    Log.loga(logTitle, 'listProduct:: url: $url');
    Log.loga(logTitle, 'listProduct:: price: $price');
    Log.loga(logTitle, 'listProduct:: brand: ${currentBrand.value}');
    Log.loga(logTitle, 'listProduct:: model: ${currentModel.value}');

    isLoading(true);
    try {
      productsList.value.clear();
      currentName.value = productName;
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
