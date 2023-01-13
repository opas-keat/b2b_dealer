import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/category.dart';
import '../../../shared/constant.dart';
import '../controllers/product_controller.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});
  ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(() => Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {
                    controller.currentCategory.value = categoryList[index].id;
                    // controller.bamsList.value.clear();
                    // controller.update();
                    // controller.listBrandAndModel();
                    controller.refreshToHome();
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: defaultPadding),
                      child: Text(
                        categoryList[index].title,
                        style: TextStyle(
                          fontWeight: (controller.currentCategory.value ==
                                  categoryList[index].id)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
