import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../controllers/product_controller.dart';

//wheel Brand, size, PCD, offset, colour, rate price
class SearchWheel extends StatelessWidget {
  SearchWheel({
    Key? key,
  }) : super(key: key);
  ProductController controller = Get.find<ProductController>();

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
                  controller: TextEditingController(text: ""),
                  decoration: const InputDecoration(
                    labelText: 'Brand',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: TextEditingController(text: ""),
                  decoration: const InputDecoration(
                    labelText: 'Size',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: TextEditingController(text: ""),
                  decoration: const InputDecoration(
                    labelText: 'PCD',
                    suffixIcon: Icon(Icons.search),
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
                  controller: TextEditingController(text: ""),
                  decoration: const InputDecoration(
                    labelText: 'Color',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TextField(
                  controller: TextEditingController(text: ""),
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
                  controller: TextEditingController(text: ""),
                  decoration: const InputDecoration(
                    labelText: 'ราคาสิ้นสุด',
                    suffixIcon: Icon(Icons.search),
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
