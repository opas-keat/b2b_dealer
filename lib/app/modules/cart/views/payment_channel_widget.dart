import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../controllers/cart_controller.dart';

class PaymentChannelWidget extends StatelessWidget {
  PaymentChannelWidget({super.key});
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InputDecorator(
        decoration: InputDecoration(
          // suffixText: "วัน",
          // labelText: 'การจ่ายเงิน',
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          helperText: 'การจ่ายเงิน',
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            elevation: 0,
            value: controller.currentPaymentChannel.value,
            isDense: true,
            // menuMaxHeight: 400,
            style: const TextStyle(
              fontSize: 18,
            ),
            onChanged: (newValue) {
              controller.updatePaymentChannel(newValue!);
            },
            items: optionPaymentChannel.entries.map((item) {
              return DropdownMenuItem<String>(
                value: item.key,
                child: Text(
                  item.value,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
