import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/cart_controller.dart';

class CartAddressWidget extends StatelessWidget {
  CartAddressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();
    return AlertDialog(
      title: const Text('ที่อยู่'),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: defaultPadding),
            const CustomText(
              text: 'รายการที่อยู่',
            ),
            const SizedBox(height: defaultPadding),
            Expanded(
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: defaultPadding / 4),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.addressList.value.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.grey.shade200,
                        child: ListTile(
                          onTap: () {
                            controller.selectedAddress.value =
                                controller.addressList.value[index];
                            controller.addressText.value.text =
                                controller.addressList.value[index].address!;
                            controller.update();
                            Get.back();
                          },
                          selectedColor: primaryColor,
                          selectedTileColor: primaryColor,
                          title: CustomText(
                            text: controller.addressList.value[index].address,
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
