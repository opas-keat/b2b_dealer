import 'package:b2b_dealer/app/data/models/product_model.dart';
import 'package:b2b_dealer/app/shared/constant.dart';
import 'package:b2b_dealer/app/shared/custom_text.dart';
import 'package:badges/badges.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import 'brand_and_model.dart';
import 'category_list.dart';
import 'prodcut_list.dart';
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
                } else if (controller.productsList.value.isNotEmpty) {
                  return ProductListWidget(
                    items: controller.productsList.value,
                  );
                } else {
                  return Text('ff');
                }
                // (controller.bamsList.value.isNotEmpty)
                //     ? BrandAndModelWidget(
                //         items: controller.bamsList.value,
                //       )
                //     : ProductListWidget(
                //         items: controller.productsList.value,
                //       ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingCartBadge extends StatelessWidget {
  ShoppingCartBadge({super.key});
  ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: defaultPadding,
      ),
      child: Badge(
        position: BadgePosition.topEnd(top: 0, end: 0),
        animationDuration: const Duration(milliseconds: 300),
        animationType: BadgeAnimationType.scale,
        badgeContent: Obx(
          () => Text(
            controller.cartTotalItem.value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: Colors.white,
          onPressed: () {
            // controller.gotoCartOrder();
          },
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
