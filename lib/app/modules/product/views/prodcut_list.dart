import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils/convert.dart';
import '../controllers/product_controller.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget({
    Key? key,
    required this.items,
  }) : super(key: key);
  ProductController controller = Get.find<ProductController>();

  final List<ProductsModel> items;

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
                    controller.showProductDetail(
                      items[index].id,
                      items[index].name,
                      items[index].url,
                      items[index].price,
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
                          items[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatterItem.format(items[index].price),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
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
