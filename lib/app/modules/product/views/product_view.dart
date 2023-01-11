import 'package:b2b_dealer/app/shared/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/category.dart';
import '../controllers/product_controller.dart';

class ProductView extends StatelessWidget {
  ProductView({Key? key}) : super(key: key);
  ProductController controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสินค้า'),
        centerTitle: true,
        // actions: <Widget>[
        //   shoppingCartBadge(),
        // ],
      ),
      body: Card(
        child: Column(
          children: [
            CategoryList(),
            Obx(
              () => (controller.currentCategory == '1')
                  ? SearchWheel()
                  : (controller.currentCategory == '2')
                      ? SearchTires()
                      : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

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
            Text("-"),
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
                    controller.update();
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
