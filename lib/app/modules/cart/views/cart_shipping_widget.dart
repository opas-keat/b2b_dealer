import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/cart_controller.dart';

class CartShippingWidget extends StatelessWidget {
  CartShippingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();
    return AlertDialog(
      title: const Text('บริษัทขนส่ง'),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: defaultPadding),
            const CustomText(
              text: 'รายชื่อขนส่ง',
            ),
            const SizedBox(height: defaultPadding),
            Expanded(
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: defaultPadding / 4),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.shippingList.value.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.grey.shade200,
                        child: ListTile(
                          onTap: () {
                            controller.selectedShipping.value =
                                controller.shippingList.value[index];
                            controller.shippingText.value.text =
                                controller.shippingList.value[index].name!;
                            controller.update();
                            Get.back();
                          },
                          selectedColor: primaryColor,
                          selectedTileColor: primaryColor,
                          title: CustomText(
                            text: controller.shippingList.value[index].name,
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("ปิด"),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
