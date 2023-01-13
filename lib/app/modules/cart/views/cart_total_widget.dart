import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils/convert.dart';
import '../controllers/cart_controller.dart';

class CartTotalWidget extends StatelessWidget {
  CartTotalWidget({super.key});
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        child: Column(
          children: [
            cardTotalDetail(
              'รายการทั้งหมด',
              formatterItem.format(controller.cartOrders.value
                  .fold(0, (sum, item) => sum + item.quantity)),
            ),
            cardTotalDetail(
              'ราคารวม',
              formatterPrice.format(
                controller.cartOrders.value.fold(
                    0, (sum, item) => sum + (item.quantity * item.fNPrice)),
              ),
            ),
            // cardTotalDetail(
            //   'ส่วนลด',
            //   formatterPrice.format(controller.discount.value),
            // ),
            cardTotalDetail(
              'ยอดรวมทั้งสิ้น',
              formatterPrice.format(
                controller.cartOrders.value.fold(
                    0, (sum, item) => sum + (item.quantity * item.fNPrice)),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFlatButton(
                  color: accentColor,
                  overlayColor: accentLightColor,
                  padding: const EdgeInsets.all(defaultPadding),
                  isWrapped: true,
                  label: 'ยืนยันสั่งซื้อสินค้า',
                  onPressed: () {
                    // controller.confirmOrder();
                    Get.defaultDialog(
                      title: 'ยืนยันสั่งซื้อสินค้า',
                      content: Column(
                        children: [
                          CustomText(
                            text: 'สั่งซื้อสินค้า จำนวน ${formatterItem.format(
                              controller.cartOrders.value
                                  .fold(0, (sum, item) => sum + item.quantity),
                            )} ชิ้น',
                          ),
                          CustomText(
                              text: 'ราคารวม ${formatterPrice.format(
                            controller.cartOrders.value.fold(
                                0,
                                (sum, item) =>
                                    sum + (item.quantity * item.fNPrice)),
                          )} บาท '),
                          const SizedBox(height: defaultPadding),
                          CustomFlatButton(
                            color: accentColor,
                            overlayColor: accentLightColor,
                            padding: const EdgeInsets.all(defaultPadding),
                            isWrapped: true,
                            label: 'ยืนยัน',
                            onPressed: () {
                              controller.confirmOrder();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row cardTotalDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text: label,
          color: label == 'ยอดรวมทั้งสิ้น'
              ? Colors.amber.shade500
              : Colors.grey.shade700,
          size: 22,
          weight: label == 'ยอดรวมทั้งสิ้น' ? FontWeight.bold : FontWeight.w600,
        ),
        Container(
          alignment: Alignment.centerRight,
          width: 150,
          child: CustomText(
            text: value,
            color: label == 'ยอดรวมทั้งสิ้น'
                ? Colors.black87
                : Colors.grey.shade700,
            size: 22,
            weight:
                label == 'ยอดรวมทั้งสิ้น' ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
