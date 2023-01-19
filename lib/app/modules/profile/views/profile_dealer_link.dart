import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:get/get.dart';

import '../../../data/graphql/graphql_dealer.dart';
import '../../../data/models/dealer_systemlink_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/profile_controller.dart';

class ProfileDealerLinkWidget extends StatelessWidget {
  ProfileDealerLinkWidget({
    Key? key,
  }) : super(key: key);
  ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Subscription(
      options: SubscriptionOptions(
        document: getDealersSubscription,
        variables: {
          "id": nhostClient.auth.currentUser!.id,
        },
      ),
      builder: (result) {
        // has error
        if (result.hasException) {
          // debugPrint(result.exception!.toString());
          return const Text('Error loading dealers data!');
        }
        //loading
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        //show data
        // print(result);
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
                  final result = await controller
                      .listSystemLinkDealerByCode(controller.dealerCode.value);
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
    );
  }
}
