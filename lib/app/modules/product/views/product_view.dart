import 'dart:html';

import 'package:badges/badges.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils/convert.dart';
import '../controllers/product_controller.dart';
import 'brand_and_model.dart';
import 'category_list.dart';
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
                } else if (controller.productsList.value.isNotEmpty) {
                  return ProductListWidget(
                    items: controller.productsList.value,
                  );
                } else {
                  // show detail
                  if (controller.product.value.id.isNotEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Hero(
                                      tag: 'mainImage',
                                      transitionOnUserGestures: true,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          controller.product.value.url,
                                          // width: double.infinity,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: CustomText(
                                        text: 'รายละเอียดสินค้า',
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 4, 0, 0),
                                    child: CustomText(
                                      text:
                                          '${formatterItem.format(controller.product.value.price)} บาท',
                                      size: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 8, 16, 8),
                                    child: CustomText(
                                      text: controller.product.value.name,
                                      size: 18,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 4, 0, 0),
                                    child: CustomText(
                                      text: 'จำนวนสินค้าที่มี 4+',
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Container(
                            // color: Colors.grey.shade100,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1, color: primaryColor),
                              ),
                            ),
                            margin: const EdgeInsets.only(
                                bottom: defaultPadding / 2),
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 130,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.minusItem();
                                        },
                                        icon: const Icon(
                                          Icons.remove_rounded,
                                          color: primaryColor,
                                          size: 22,
                                        ),
                                      ),
                                      Text(
                                        controller.itemCount.value.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.addItem();
                                        },
                                        icon: const Icon(
                                          Icons.add_rounded,
                                          color: primaryColor,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: defaultPadding),
                                SizedBox(
                                  width: 150,
                                  child: CustomFlatButton(
                                    onPressed: () {},
                                    label: 'เพิ่มลงรถเข็น',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                    // return Expanded(
                    //   child: CustomScrollView(
                    //     slivers: [
                    //       SliverFillRemaining(
                    //         hasScrollBody: true,
                    //         child: Expanded(
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               SizedBox(
                    //                 width: 300,
                    //                 child: Image.network(
                    //                   controller.product.value.url,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsetsDirectional.fromSTEB(
                    //                     16, 0, 16, 0),
                    //                 child: CustomText(
                    //                   text: 'รายละเอียดสินค้า',
                    //                   size: 26,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsetsDirectional.fromSTEB(
                    //                     16, 4, 0, 0),
                    //                 child: CustomText(
                    //                   text:
                    //                       '${formatterItem.format(controller.product.value.price)} บาท',
                    //                   size: 22,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsetsDirectional.fromSTEB(
                    //                     16, 8, 16, 8),
                    //                 child: CustomText(
                    //                   text: '${controller.product.value.name}',
                    //                   size: 18,
                    //                 ),
                    //               ),
                    //               // for (int i = 0; i < 30; i++) ...[
                    //               //   Text('$i'),
                    //               // ]
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  } else {
                    return SizedBox(width: 0);
                  }
                }
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
