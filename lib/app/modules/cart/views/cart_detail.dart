import 'package:b2b_dealer/app/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/constant.dart';
import '../controllers/cart_controller.dart';
import 'cart_address_widget.dart';
import 'cart_shipping_widget.dart';
import 'payment_channel_widget.dart';

class CartDetailWidget extends StatelessWidget {
  CartDetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // CustomText(
        //   text: 'คำสั่งซื้อที่ ${controller.preSaleOrderNo.value}',
        //   size: 20,
        // ),
        CustomText(
          text: 'วันที่ ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
          size: 20,
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.addressText.value,
                decoration: InputDecoration(
                  helperText: 'ที่อยู่จัดส่งสินค้า',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Get.dialog(
                        CartAddressWidget(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                child: PaymentChannelWidget(),
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.shippingText.value,
                decoration: InputDecoration(
                  helperText: 'บริษัทขนส่ง',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Get.dialog(
                        CartShippingWidget(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                child: TextField(
                  controller: controller.shippingDateText.value,
                  decoration: InputDecoration(
                    helperText: 'วันที่นัดส่งสินค้า',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await showDatePicker(
                          locale: const Locale('th', 'TH'),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 2),
                        ).then((value) {
                          controller.shippingDateText.value.text =
                              DateFormat('dd/MM/yyyy').format(value!);
                          controller.update();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: const [
            Expanded(
              child: Text(
                'รายการสินค้า',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
