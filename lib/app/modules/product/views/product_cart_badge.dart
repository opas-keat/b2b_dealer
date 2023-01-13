import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../controllers/product_controller.dart';

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
