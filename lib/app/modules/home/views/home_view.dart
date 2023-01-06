import 'package:b2b_dealer/app/modules/history/views/history_view.dart';
import 'package:b2b_dealer/app/modules/product/views/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/models/menu.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../cart/views/cart_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: Row(
            children: [
              // side menu
              SideMenu(),

              Expanded(
                child: IndexedStack(
                  index: controller.navIndex.value,
                  children: [
                    ProductView(),
                    CartView(),
                    HistoryView(),
                    ProfileView(),
                  ],
                ),
              ),

              // controller.checkDealers.value
              //     ? Expanded(
              //         child: IndexedStack(
              //         index: controller.navIndex.value,
              //         children: [
              //           ProductView(),
              //           CartView(),
              //           HistoryView(),
              //           ProfileView(),
              //         ],
              //       ))
              //     : Expanded(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             const Text(
              //               'กรุณา',
              //               style: TextStyle(fontSize: 20),
              //             ),
              //             const SizedBox(width: defaultPadding),
              //             TextButton(
              //               onPressed: () => Get.offAllNamed(Routes.SIGNIN),
              //               child: const Text(
              //                 'ตั้งค่าที่อยู่',
              //                 style: TextStyle(
              //                   decoration: TextDecoration.underline,
              //                   fontSize: 20,
              //                   color: primaryLightColor,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
            ],
          ),
        );
      },
    );
  }
}

class SideMenu extends GetView<HomeController> {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  // HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: 180,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SizedBox(
              height: 150,
              child: SvgPicture.network(
                  "assets/icons/undraw_sweet_home_dkhr.svg",
                  fit: BoxFit.contain),
            ),
          ),
          const Text(
            "เมนูการทำงาน",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: ListView.builder(
              // itemCount: menuItemsAdmin.length,
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    menuItems[index].title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: (controller.navIndex.value == index)
                          ? FontWeight.w800
                          : FontWeight.w300,
                    ),
                  ),
                  onTap: () {
                    if (controller.menus[index].title == 'ออกจากระบบ') {
                      Get.offNamed(Routes.SIGNIN);
                    } else {
                      controller.navIndex.value = index;
                      controller.update();
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
