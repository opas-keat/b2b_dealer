import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../../shared/constant.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/product_controller.dart';

class ShoppingCartBadge extends StatelessWidget {
  ShoppingCartBadge({super.key});
  ProductController controller = Get.find<ProductController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: defaultPadding / 2,
        right: defaultPadding + 8,
      ),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(),
        badgeAnimation: const badges.BadgeAnimation.slide(
          animationDuration: Duration(seconds: 1),
          toAnimate: true,
        ),
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
            homeController.navIndex.value = 1;
          },
        ),
      ),
    );
  }
}
