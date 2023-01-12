import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../../shared/constant.dart';
import '../controllers/product_controller.dart';

class BrandAndModelWidget extends StatelessWidget {
  BrandAndModelWidget({
    Key? key,
    required this.items,
  }) : super(key: key);
  ProductController controller = Get.find<ProductController>();

  final List<BrandAndModel> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: CustomScrollView(
          shrinkWrap: true,
          primary: false,
          slivers: [
            SliverDynamicHeightGridView(
              itemCount: items.length,
              crossAxisCount: 5,
              builder: (ctx, index) {
                return InkWell(
                  hoverColor: Colors.grey.shade300,
                  onTap: () {
                    controller.listProduct(
                      items[index].brand,
                      items[index].model,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Image.network(
                            items[index].url,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "ยี่ห้อ: ${items[index].brand}",
                          style: const TextStyle(
                            // fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "รุ่น: ${items[index].model}",
                          style: const TextStyle(
                            // fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        // Text("ราคา : ${items[index].fNPrice.toString()}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
