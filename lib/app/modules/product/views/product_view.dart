import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/product_controller.dart';
import 'brand_and_model.dart';
import 'category_list.dart';
import 'product_cart_badge.dart';
import 'product_detail.dart';
import 'product_list.dart';
import 'search_tires.dart';
import 'search_wheel.dart';

class ProductView extends StatelessWidget {
  ProductView({Key? key}) : super(key: key);
  ProductController controller = Get.put(ProductController());
  final scrollBarController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสินค้า'),
        centerTitle: true,
        actions: <Widget>[
          ShoppingCartBadge(),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            CategoryList(),
            Obx(() {
              if (controller.productsList.value.isNotEmpty) {
                if (controller.currentCategory == '1') {
                  return SearchWheel();
                } else if (controller.currentCategory == '2') {
                  return SearchTires();
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            }),
            const SizedBox(height: defaultPadding / 2),
            NavigatorWidget(controller: controller),
            GetBuilder<ProductController>(
              init: controller,
              builder: (controller) {
                // loading
                if (controller.isLoading.value) {
                  return Center(
                    child: const CircularProgressIndicator().reactive(),
                  );
                }
                // show data
                if (controller.bamsList.value.isNotEmpty) {
                  return BrandAndModelWidget(
                    items: controller.bamsList.value,
                  );
                }
                if (controller.productsList.value.isNotEmpty) {
                  return ProductListWidget(
                    items: controller.productsList.value,
                  );
                }
                // show detail
                if (controller.product.value.id.isNotEmpty) {
                  return ProductDeatilWidget();
                } else {
                  return SizedBox(width: 0);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            color: primaryColor,
            iconSize: 30,
            onPressed: () {
              controller.refreshToHome();
            },
          ),

          // (controller.currentBrand.value.isNotEmpty)
          //     ? CustomText(
          //         text:
          //             "> ยี่ห้อ: ${controller.currentBrand.value} รุ่น: ${controller.currentModel.value}",
          //       )
          //     : const CustomText(
          //         text: "รายการยี่ห้อและรุ่น",
          //       ),

          if (controller.currentBrand.value.isEmpty) ...[
            const CustomText(
              text: "รายการยี่ห้อและรุ่น",
            ),
          ] else ...[
            CustomText(
              text:
                  "> ยี่ห้อ: ${controller.currentBrand.value} รุ่น: ${controller.currentModel.value}",
            ),
            if (controller.currentName.value.isNotEmpty) ...[
              CustomText(
                text:
                    " : ${controller.currentName.value.characters.take(30)} ...",
              ),
            ]
          ]

          // (controller.currentName.value.isNotEmpty)
          //     ? () {
          //       CustomText(
          //         text:
          //             "> ยี่ห้อ: ${controller.currentBrand.value} รุ่น: ${controller.currentModel.value}",
          //       ),
          //         CustomText(
          //           text: " : ${controller.currentName.value}",
          //         ),
          //       }
          //     : const SizedBox(
          //         width: 0,
          //       ),
        ],
      ),
    );
  }
}
