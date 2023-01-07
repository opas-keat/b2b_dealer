import 'package:graphql/client.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart';
import 'package:get/get.dart';

import '../../../data/graphql/graphql_dealer.dart';
import '../../../data/models/menu.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils/log_util.dart';

final logTitle = "HomeController";

class HomeController extends GetxController {
  RxInt navIndex = 0.obs;
  List<MenuItem> menus =
      menuItems.where((element) => element.isShow == true).toList();

  @override
  void onInit() {
    getSingInDealerCode();
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

  Future<void> getSingInDealerCode() async {
    final result = await nhostClient.auth.currentUser!.metadata['dealerCode'];
    // Log.loga(logTitle, 'getSingInDealerCode:: ${result}');

    final graphqlClient = createNhostGraphQLClient(nhostClient);
    // Run a query, unauthenticated
    var queryResult = await graphqlClient.query(
      QueryOptions(document: getDealers, variables: {
        'dealerCode': result.toString() + '1',
      }),
    );
    if (queryResult.hasException) {
      Log.loga(logTitle, 'getSingInDealerCode:: ${queryResult.exception}');
    }
    List? dealers = queryResult.data!['dealers'];
    if (dealers!.isNotEmpty) {
      navIndex.value = 0;
    } else {
      navIndex.value = 3;
    }
    update();
  }
}
