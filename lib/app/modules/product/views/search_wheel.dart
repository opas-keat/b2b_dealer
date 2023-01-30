import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../controllers/product_controller.dart';

//wheel Brand, size, PCD, offset, colour, rate price
class SearchWheel extends StatelessWidget {
  SearchWheel({
    Key? key,
  }) : super(key: key);
  ProductController controller = Get.find<ProductController>();

  final brandTextController = TextEditingController(text: "");
  final sizeTextController = TextEditingController();
  final pcdTextController = TextEditingController();
  final colorTextController = TextEditingController();
  final priceBeginTextController = TextEditingController();
  final priceEndTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: brandTextController,
                  decoration: InputDecoration(
                    labelText: 'Brand',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.searchProductWheel(
                          brandTextController.text,
                          sizeTextController.text,
                          pcdTextController.text,
                          colorTextController.text,
                          priceBeginTextController.text,
                          priceEndTextController.text,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: sizeTextController,
                  decoration: InputDecoration(
                    labelText: 'Size',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.searchProductWheel(
                          brandTextController.text,
                          sizeTextController.text,
                          pcdTextController.text,
                          colorTextController.text,
                          priceBeginTextController.text,
                          priceEndTextController.text,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: pcdTextController,
                  decoration: InputDecoration(
                    labelText: 'PCD',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.searchProductWheel(
                          brandTextController.text,
                          sizeTextController.text,
                          pcdTextController.text,
                          colorTextController.text,
                          priceBeginTextController.text,
                          priceEndTextController.text,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: colorTextController,
                  decoration: InputDecoration(
                    labelText: 'Color',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.searchProductWheel(
                          brandTextController.text,
                          sizeTextController.text,
                          pcdTextController.text,
                          colorTextController.text,
                          priceBeginTextController.text,
                          priceEndTextController.text,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: priceBeginTextController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'ราคาเริ่มต้น',
                  ),
                ),
              ),
            ),
            const Text("-"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: priceEndTextController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'ราคาสิ้นสุด',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.searchProductWheel(
                          brandTextController.text,
                          sizeTextController.text,
                          pcdTextController.text,
                          colorTextController.text,
                          priceBeginTextController.text,
                          priceEndTextController.text,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
