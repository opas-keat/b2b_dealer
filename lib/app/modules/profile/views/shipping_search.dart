import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/profile_controller.dart';

class ShippingSearchWidget extends StatelessWidget {
  ShippingSearchWidget({
    Key? key,
  }) : super(key: key);
  ProfileController controller = Get.find<ProfileController>();

  final _textShippingName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('บริษัทขนส่ง'),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: _textShippingName,
              decoration: InputDecoration(
                hintText: "",
                labelText: "ชื่อ",
                suffixIcon: IconButton(
                  color: primaryColor,
                  onPressed: () {
                    controller.listShippingFromSystemLink('ขนส่ง');
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Checkbox(
                  value: controller.checkedBKKRegion.value,
                  onChanged: (newValue) {
                    controller.checkedBKKRegion.value = newValue!;
                  },
                ),
                const CustomText(
                  text: 'กรุงเทพและปริมณฑล',
                ),
                Checkbox(
                  value: controller.checkedCentralRegion.value,
                  onChanged: (newValue) {
                    controller.checkedCentralRegion.value = newValue!;
                  },
                ),
                const CustomText(
                  text: 'ภาคกลาง',
                ),
                Checkbox(
                  value: controller.checkedEastRegion.value,
                  onChanged: (newValue) {
                    controller.checkedEastRegion.value = newValue!;
                  },
                ),
                const CustomText(
                  text: 'ภาคตะวันออก',
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: controller.checkedNorthEastRegion.value,
                  onChanged: (newValue) {
                    controller.checkedNorthEastRegion.value = newValue!;
                  },
                ),
                const CustomText(
                  text: 'ภาคอีสาน',
                ),
                Checkbox(
                  value: controller.checkedNorthRegion.value,
                  onChanged: (newValue) {
                    controller.checkedNorthRegion.value = newValue!;
                  },
                ),
                const CustomText(
                  text: 'ภาคเหนือ',
                ),
                Checkbox(
                  value: controller.checkedSouthernRegion.value,
                  onChanged: (newValue) {
                    controller.checkedSouthernRegion.value = newValue!;
                  },
                ),
                const CustomText(
                  text: 'ภาคใต้',
                ),
                Checkbox(
                  value: controller.checkedWestRegion.value,
                  onChanged: (newValue) {
                    controller.checkedWestRegion.value = newValue!;
                  },
                ),
                const CustomText(
                  text: 'ภาคตะวันตก',
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            const CustomText(
              text: 'รายชื่อขนส่ง',
            ),
            const SizedBox(height: defaultPadding),
            Expanded(
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: defaultPadding / 4),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.shippingList.value.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.grey.shade200,
                        child: ListTile(
                          onTap: () async {
                            final result = await controller.addShipping(
                              controller.shippingList.value[index].id
                                  .toString(),
                              controller.shippingList.value[index].name
                                  .toString(),
                            );
                            Get.back();
                          },
                          selectedColor: primaryColor,
                          selectedTileColor: primaryColor,
                          title: CustomText(
                            text: controller.shippingList.value[index].name,
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
        // TextButton(
        //   child: const Text("เพิ่ม"),
        //   onPressed: () {},
        // ),
        TextButton(
          child: const Text("ปิด"),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
