import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/utils/convert.dart';
import '../controllers/cart_controller.dart';

class CartListWidget extends StatelessWidget {
  CartListWidget({
    Key? key,
  }) : super(key: key);
  CartController controller = Get.find<CartController>();

  final scrollBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollBarController,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(defaultPadding),
            controller: scrollBarController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "${index + 1}. ${controller.cartOrders[index].fTProdNameTH}",
                      style: const TextStyle(
                        // color: darkBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "ราคา: ${controller.cartOrders[index].fNPrice}",
                    ),
                    // subtitle: Text(
                    //   "ราคา: ${controller.cartOrders[index].fNDealerPrice1} จำนวน: ${controller.cartOrders[index].quantity}",
                    // ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.minusItem(index);
                                },
                                icon: const Icon(
                                  Icons.remove_rounded,
                                  color: primaryColor,
                                  size: 14,
                                ),
                              ),
                              Text(
                                controller.cartOrders[index].quantity
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.plusItem(index);
                                },
                                icon: const Icon(
                                  Icons.add_rounded,
                                  color: primaryColor,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        Text(
                          formatterItem.format(
                            controller.cartOrders[index].fNPrice *
                                controller.cartOrders[index].quantity,
                          ),
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: defaultPadding / 2,
                  ),
                ],
              );
            },
            itemCount: controller.cartOrders.length,
          ),
        ),
      ),
    );
  }
}
