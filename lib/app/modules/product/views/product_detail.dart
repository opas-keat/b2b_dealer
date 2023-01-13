import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils/convert.dart';
import '../controllers/product_controller.dart';

class ProductDeatilWidget extends StatelessWidget {
  ProductDeatilWidget({
    Key? key,
  }) : super(key: key);

  ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: CustomText(
                        text: 'รายละเอียดสินค้า',
                        size: 26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                    child: CustomText(
                      text:
                          '${formatterItem.format(controller.product.value.price)} บาท',
                      size: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                    child: CustomText(
                      text: controller.product.value.name,
                      size: 18,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
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
            margin: const EdgeInsets.only(bottom: defaultPadding / 2),
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: 130,
                //   height: 45,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     shape: BoxShape.rectangle,
                //     border: Border.all(
                //       color: primaryColor,
                //       width: 2,
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       IconButton(
                //         onPressed: () {
                //           controller.minusItem();
                //         },
                //         icon: const Icon(
                //           Icons.remove_rounded,
                //           color: primaryColor,
                //           size: 22,
                //         ),
                //       ),
                //       Text(
                //         controller.itemCount.value.toString(),
                //         style: const TextStyle(
                //           fontSize: 18,
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () {
                //           controller.addItem();
                //         },
                //         icon: const Icon(
                //           Icons.add_rounded,
                //           color: primaryColor,
                //           size: 22,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(width: defaultPadding),
                SizedBox(
                  width: 200,
                  child: CustomFlatButton(
                    onPressed: () {
                      controller.addItemToCart();
                    },
                    label: 'เพิ่มลงรถเข็น',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
