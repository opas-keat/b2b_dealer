import 'package:b2b_dealer/app/data/models/shipping_request/criteria.dart';
import 'package:graphql/client.dart';
import 'package:get/get.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart';

import '../../../api/api.dart';
import '../../../api/api_end_points.dart';
import '../../../api/api_utils.dart';
import '../../../data/graphql/graphql_dealer.dart';
import '../../../data/models/dealer_systemlink_model.dart';
import '../../../data/models/shipping_request/shipping_request.dart';
import '../../../data/models/shipping_response_model/shipping_response_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils/log_util.dart';

class ProfileController extends GetxController {
  final logTitle = "ProfileController";
  RxString signUpError = ''.obs;
  RxBool checkDealer = false.obs;
  RxString dealerCode = "".obs;

  final offset = 0.obs;
  final limit = 50.obs;

  @override
  void onInit() {
    getSingInDealerCode();
    listShipping();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  listShipping() async {
    Log.loga(logTitle, 'listShipping:: start');
    try {
      final res = await apiUtils.post(
        url: "${Api.baseUrlSystemLink}${ApiEndPoints.systemLinkShippings}/",
        data: ShippingRequest(
          limit: limit.value,
          offset: offset.value,
          criteria: ShippingRequestCriteria(),
        ).toJson(),
      );
      final shippingResponse = ShippingResponse.fromJson(res.data);
      final shippingDatas = shippingResponse.data;
      // deaker list from system link
      final shippingList = shippingDatas!.rows;
    } catch (e) {
      Log.loga(logTitle, 'Error:: ${e}');
      signUpError.value = '${e}';
      return false;
    }
  }

  Future<void> getSingInDealerCode() async {
    final result = nhostClient.auth.currentUser!.metadata['dealerCode'];
    // Log.loga(logTitle, 'getSingInDealerCode:: ${result}');
    dealerCode.value = result.toString();
    // final graphqlClient = createNhostGraphQLClient(nhostClient);
    // // Run a query, unauthenticated
    // var queryResult = await graphqlClient.query(
    //   QueryOptions(document: getDealers, variables: {
    //     'dealerCode': result.toString(),
    //   }),
    // );
    // // Log.loga(logTitle, 'getSingInDealerCode:: ${queryResult.data!['dealers']}');
    // List? dealers = queryResult.data!['dealers'];
    // if (dealers!.isNotEmpty) {
    //   checkDealer.value = true;
    // } else {
    //   checkDealer.value = false;
    // }
    // update();
  }

  Future<bool> listSystemLinkDealerByCode(String dealerCode) async {
    try {
      final res = await apiUtils.post(
        url: "${Api.baseUrlSystemLink}${ApiEndPoints.systemLinkDealers}/",
        data: DealerSystemLinkRequest(
          limit: 50,
          criteria: DealerSystemLinkCriteria(
            dealerCode: dealerCode,
          ),
        ).toJson(),
      );
      final dealerResponse = DealerSystemLinkResponse.fromJson(res.data);
      final dealerSystemLink = dealerResponse.data;
      // deaker list from system link
      final dealerList = dealerSystemLink.rows;

      //user id
      final userId = nhostClient.auth.currentUser!.id;

      // dealer list for Insert
      final dealerInsert = <DealerInsert>[];
      for (var element in dealerList) {
        dealerInsert.add(DealerInsert(
          address: element.address,
          linkId: element.id,
          name: element.name,
          phone: element.phone,
          dealerCode: element.code,
          createdBy: userId,
        ));
      }
      // Log.loga(logTitle, 'delaerInsert:: ${delaerInsert}');
      //Insert dealers
      final graphqlClient = createNhostGraphQLClient(nhostClient);
      var mutationResult = await graphqlClient.mutate(
        MutationOptions(document: createDealers, variables: {
          'dealers': dealerInsert,
        }),
      );
      return true;
    } catch (e) {
      Log.loga(logTitle, 'Error:: ${e}');
      signUpError.value = '${e}';
      return false;
    }
  }
}
