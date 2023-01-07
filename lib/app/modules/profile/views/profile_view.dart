import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

import '../../../data/graphql/graphql_dealer.dart';
import '../../../data/graphql/graphql_users.dart';
import '../../../data/models/dealer_systemlink_model.dart';
import '../../../data/models/user_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  final scrollBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตั้งค่า'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
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
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                        trailing: dealers[index].setDefault
                            ? Icon(
                                Icons.check,
                              )
                            : SizedBox(),
                      );
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