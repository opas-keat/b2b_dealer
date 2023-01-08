import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

import '../../../data/graphql/graphql_dealer.dart';
import '../../../data/graphql/graphql_users.dart';
import '../../../data/models/dealer_systemlink_model.dart';
import '../../../data/models/user_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/validator.dart';
import '../controllers/profile_controller.dart';

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
          SizedBox(
            height: 220,
            child: Subscription(
              options: SubscriptionOptions(
                document: getUserProfileSubscription,
              ),
              builder: (result) {
                // has error
                if (result.hasException) {
                  return const Text('Error loading user data!');
                }
                //loading
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                //show data
                // debugPrint('${result.data}');
                final users = (result.data!['users'] as List)
                    .map((e) => UserResponse.fromMap(e))
                    .toList();
                // debugPrint('${users.first.id}');
                return ListView(
                  controller: scrollBarController,
                  padding: const EdgeInsets.all(defaultPadding * 2),
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: primaryColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(users.first.avatarUrl),
                        radius: 70,
                      ),
                    ),
                    Center(
                      child: Text(
                        users.first.displayName,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          Padding(
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
              child: const ListTile(
                leading: Icon(
                  Icons.maps_home_work,
                ),
                title: CustomText(
                  text: 'ที่อยู่',
                  size: 24,
                ),
                dense: false,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Subscription(
            options: SubscriptionOptions(
              document: getDealersSubscription,
              variables: {
                "id": nhostClient.auth.currentUser!.id,
              },
            ),
            builder: (result) {
              // has error
              if (result.hasException) {
                debugPrint(result.exception!.toString());
                return const Text('Error loading dealers data!');
              }
              //loading
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              //show data
              // final dealers = DealerInsert.fromJson(result.data!['dealers']);
              final dealers = (result.data!['dealers'] as List)
                  .map((e) => DealerResponseSubscription.fromMap(e))
                  .toList();
              if (dealers.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: defaultPadding / 2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 3,
                    ),
                    itemCount: dealers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: CustomText(
                          text:
                              '${dealers[index].dealerCode} : ${dealers[index].name}',
                          size: 18,
                        ),
                        subtitle: Text(
                          '${dealers[index].address}\n${dealers[index].phone}',
                        ),
                        isThreeLine: true,
                        tileColor: const Color(0xFFF5F5F5),
                        dense: false,
                      );
                      // return Mutation(
                      //   options: MutationOptions(
                      //       document: createDealers,
                      //       variables: {
                      //         'dealers': delaerUpdateSetDefault,
                      //       }),
                      //   builder: (runMutation, result) {
                      //     return ListTile(
                      //       title: CustomText(
                      //         text:
                      //             '${dealers[index].dealerCode} : ${dealers[index].name}',
                      //         size: 18,
                      //       ),
                      //       subtitle: Text(
                      //         '${dealers[index].address}\n${dealers[index].phone}',
                      //       ),
                      //       isThreeLine: true,
                      //       tileColor: Color(0xFFF5F5F5),
                      //       dense: false,
                      //       trailing: dealers[index].setDefault
                      //           ? const Icon(
                      //               Icons.check,
                      //             )
                      //           : const SizedBox(),
                      //       onTap: () {},
                      //     );
                      //   },
                      // );
                    },
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'กรุณา',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: defaultPadding),
                    TextButton(
                      onPressed: () async {
                        Get.dialog(
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          barrierDismissible: false,
                        );
                        // list dealer with dealer_code
                        final result =
                            await controller.listSystemLinkDealerByCode(
                                controller.dealerCode.value);
                        Get.back();
                        result
                            ? controller.getSingInDealerCode()
                            : Get.snackbar(
                                'Error',
                                controller.signUpError.value,
                                backgroundColor: accentColor,
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                icon: const Icon(
                                  Icons.lock_person_outlined,
                                  color: Colors.white,
                                ),
                                isDismissible: true,
                                margin: const EdgeInsets.all(
                                  defaultPadding,
                                ),
                              );
                      },
                      child: const Text(
                        'ตั้งค่าที่อยู่',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: primaryLightColor,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 2,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: primaryColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const ListTile(
                      leading: Icon(
                        Icons.key_sharp,
                      ),
                      title: CustomText(
                        text: 'รหัสผ่าน',
                        size: 24,
                      ),
                      dense: false,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
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
          ),
          const SizedBox(height: defaultPadding),
        ],
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
