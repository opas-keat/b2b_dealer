import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/graphql/graphql_shipping.dart';
import '../../../data/models/shipping_response_subscription.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/validator.dart';
import '../controllers/profile_controller.dart';
import 'profile_dealer_link.dart';
import 'profile_detail.dart';
import 'shipping_search.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  final scrollBarController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  final _textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตั้งค่า'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ProfileDetailWidget(),
          const SizedBox(height: defaultPadding),
          ProfileCategoryWidget(categoryTitle: 'ที่อยู่'),
          const SizedBox(height: defaultPadding),
          ProfileDealerLinkWidget(),
          const SizedBox(height: defaultPadding),
          ProfileCategoryWidget(categoryTitle: 'ขนส่ง'),
          const SizedBox(height: defaultPadding),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Subscription(
                  options: SubscriptionOptions(
                    document: subscriptionShipping,
                    variables: {
                      "limit": 20,
                      "offset": 0,
                      "created_by": {
                        "_eq": nhostClient.auth.currentUser!.id,
                      }
                    },
                  ),
                  builder: (result) {
                    // has error
                    if (result.hasException) {
                      return const Text('Error loading dealers data!');
                    }
                    //loading
                    if (result.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    //show data
                    final shippings = (result.data!['shippings'] as List)
                        .map((e) => ShippingResponseSubscription.fromMap(e))
                        .toList();
                    // print(shippings);
                    if (shippings.isNotEmpty) {
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: defaultPadding / 2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 3,
                          ),
                          itemCount: shippings.length,
                          itemBuilder: (context, index) {
                            return Material(
                              color: Color(0xFFF5F5F5),
                              child: ListTile(
                                title: CustomText(
                                  text: shippings[index].name,
                                  size: 18,
                                ),
                                dense: false,
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: defaultPadding),
                    TextButton(
                      onPressed: () async {
                        Get.dialog(
                          ShippingSearchWidget(),
                          barrierDismissible: false,
                        );
                      },
                      child: const Text(
                        'เพิ่มขนส่ง',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: primaryLightColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ProfileCategoryWidget(categoryTitle: 'รหัสผ่าน'),
          const SizedBox(height: defaultPadding),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 3,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding,
                    ),
                    color: const Color(0xFFF5F5F5),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            flex: 2,
                            child: SizedBox(height: defaultPadding),
                          ),
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              cursorColor: primaryColor,
                              controller: _textPassword,
                              decoration: const InputDecoration(
                                hintText: 'New Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              validator: (value) =>
                                  validateNotEmpty(value!, 'New Password'),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                              ),
                              child: CustomFlatButton(
                                label: 'Update'.toUpperCase(),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Get.dialog(
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      barrierDismissible: false,
                                    );
                                    await nhostClient.auth.changePassword(
                                      newPassword: _textPassword.text,
                                    );
                                    Get.offAllNamed(Routes.SIGNIN);
                                  }
                                },
                              ),
                            ),
                          ),
                          const Flexible(
                            flex: 2,
                            child: SizedBox(height: defaultPadding),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}

class ProfileCategoryWidget extends StatelessWidget {
  ProfileCategoryWidget({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: primaryColor,
              width: 1.0,
            ),
          ),
        ),
        child: ListTile(
          leading: const Icon(
            Icons.maps_home_work,
          ),
          title: CustomText(
            text: categoryTitle,
            size: 24,
          ),
          dense: false,
        ),
      ),
    );
  }
}



// const SizedBox(height: defaultPadding),
// Container(
//   decoration: BoxDecoration(
//     border: Border(
//       bottom: BorderSide(
//         color: primaryColor,
//         width: 1.0,
//       ),
//     ),
//   ),
//   child: ListTile(
//     leading: Icon(
//       Icons.maps_home_work,
//     ),
//     title: CustomText(
//       text: 'ที่อยู่',
//       size: 24,
//     ),
//     dense: false,
//   ),
// ),
// controller.checkDealer.value
//     ? Column(
//         children: [

//           ExpansionTile(
//             collapsedBackgroundColor: Colors.grey.shade200,

//             initiallyExpanded: true,
//             collapsedTextColor: primaryColor,
//             leading:
//                 Icon(Icons.map_outlined, color: primaryColor),
//             // backgroundColor: primaryLightColor,
//             // title: Text(
//             //   "ที่อยู่",
//             //   style: TextStyle(
//             //       fontSize: 16.0, fontWeight: FontWeight.w500),
//             // ),
//             title: ListTile(
//               leading: Icon(Icons.maps_home_work_sharp),
//               title: CustomText(
//                 text: 'ที่อยู่',
//                 size: 20,
//               ),
//             ),
//             children: <Widget>[
//               ListTile(
//                 title: Text(
//                   "1",
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   "2",
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//               )
//             ],
//           ),
//         ],
//       )
//     : Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'กรุณา',
//             style: TextStyle(fontSize: 20),
//           ),
//           const SizedBox(width: defaultPadding),
//           TextButton(
//             onPressed: () async {
//               Get.dialog(
//                 const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 barrierDismissible: false,
//               );
//               // list dealer with dealer_code
//               final result =
//                   await controller.listSystemLinkDealerByCode(
//                       controller.dealerCode.value);
//               Get.back();
//               result
//                   ? controller.getSingInDealerCode()
//                   : Get.snackbar(
//                       'Error',
//                       controller.signUpError.value,
//                       backgroundColor: accentColor,
//                       snackPosition: SnackPosition.BOTTOM,
//                       colorText: Colors.white,
//                       icon: const Icon(
//                         Icons.lock_person_outlined,
//                         color: Colors.white,
//                       ),
//                       isDismissible: true,
//                       margin: const EdgeInsets.all(
//                         defaultPadding,
//                       ),
//                     );
//             },
//             child: const Text(
//               'ตั้งค่าที่อยู่',
//               style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 fontSize: 20,
//                 color: primaryLightColor,
//               ),
//             ),
//           ),
//         ],
//       ),

                        // list dealer with dealer_code
                        // final result =
                        //     await controller.listSystemLinkDealerByCode(
                        //         controller.dealerCode.value);
                        // Get.back();
                        // result
                        //     ? controller.getSingInDealerCode()
                        //     : Get.snackbar(
                        //         'Error',
                        //         controller.signUpError.value,
                        //         backgroundColor: accentColor,
                        //         snackPosition: SnackPosition.BOTTOM,
                        //         colorText: Colors.white,
                        //         icon: const Icon(
                        //           Icons.lock_person_outlined,
                        //           color: Colors.white,
                        //         ),
                        //         isDismissible: true,
                        //         margin: const EdgeInsets.all(
                        //           defaultPadding,
                        //         ),
                        //       );