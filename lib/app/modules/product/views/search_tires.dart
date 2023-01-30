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

  final brandTextController = TextEditingController(text: "");
  final sizeTextController = TextEditingController();
  final yearTextController = TextEditingController();
  final speedIndexTextController = TextEditingController();
  final loadIndexTextController = TextEditingController();
  final patternTextController = TextEditingController();

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
                        controller.SearchProductTires(
                          brandTextController.text,
                          sizeTextController.text,
                          yearTextController.text,
                          speedIndexTextController.text,
                          loadIndexTextController.text,
                          patternTextController.text,
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
                    labelText: 'Brand',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.SearchProductTires(
                          brandTextController.text,
                          sizeTextController.text,
                          yearTextController.text,
                          speedIndexTextController.text,
                          loadIndexTextController.text,
                          patternTextController.text,
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
                  controller: yearTextController,
                  decoration: InputDecoration(
                    labelText: 'Brand',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.SearchProductTires(
                          brandTextController.text,
                          sizeTextController.text,
                          yearTextController.text,
                          speedIndexTextController.text,
                          loadIndexTextController.text,
                          patternTextController.text,
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
                  controller: speedIndexTextController,
                  decoration: InputDecoration(
                    labelText: 'Brand',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.SearchProductTires(
                          brandTextController.text,
                          sizeTextController.text,
                          yearTextController.text,
                          speedIndexTextController.text,
                          loadIndexTextController.text,
                          patternTextController.text,
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
                  controller: loadIndexTextController,
                  decoration: InputDecoration(
                    labelText: 'Brand',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.SearchProductTires(
                          brandTextController.text,
                          sizeTextController.text,
                          yearTextController.text,
                          speedIndexTextController.text,
                          loadIndexTextController.text,
                          patternTextController.text,
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
                  controller: patternTextController,
                  decoration: InputDecoration(
                    labelText: 'Brand',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.SearchProductTires(
                          brandTextController.text,
                          sizeTextController.text,
                          yearTextController.text,
                          speedIndexTextController.text,
                          loadIndexTextController.text,
                          patternTextController.text,
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
