import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../controllers/product_controller.dart';

//tire brand, size (width, ratio, diameter), dot(ปีและเดือนที่ผลิต), speed index, load index, pattern(ดอกยาง)
class SearchTires extends StatelessWidget {
  SearchTires({
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
                    labelText: 'Size (width, ratio, diameter)',
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
                    labelText: 'Dot (ปีและเดือนที่ผลิต)',
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
                    labelText: 'Speed index',
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
                    labelText: 'Load index',
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
                    labelText: 'Pattern (ดอกยาง)',
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
