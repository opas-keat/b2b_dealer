import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../controllers/cart_controller.dart';
import 'cart_detail.dart';
import 'cart_list.dart';
import 'cart_total_widget.dart';
import 'payment_channel_widget.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสั่งซื้อ'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 2,
                  vertical: defaultPadding,
                ),
                child: Column(
                  children: [
                    CartDetailWidget(),
                    CartListWidget(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          CartTotalWidget(),
          const SizedBox(height: defaultPadding / 2),
        ],
      ),
    );
  }
}
