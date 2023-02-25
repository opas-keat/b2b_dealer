import 'dart:developer';

import 'package:b2b_dealer/app/data/graphql/graphql_logs.dart';
import 'package:graphql/client.dart';

import 'package:get/get.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

import '../../../api/services/logs_service.dart';
import '../../../data/graphql/graphql_dealer.dart';
import '../../../data/models/dealer_service_model.dart';
import '../../../data/models/logs_service_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils/log_util.dart';

class SigninController extends GetxController {
  final title = "SigninController";
  RxString signInError = ''.obs;
  @override
  void onInit() {
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

  Future<bool> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await nhostClient.auth
          .signInEmailPassword(email: email, password: password);
      if (authResponse.user != null) {
        final result = nhostClient.auth.currentUser!.metadata['dealerCode'];
        final graphqlClient = createNhostGraphQLClient(nhostClient);
        var queryResult = await graphqlClient.query(
          QueryOptions(document: getDealers, variables: {
            'dealerCode': result.toString(),
          }),
        );
        final response = (queryResult.data!['dealers'] as List)
            .map((e) => DealersResponse.fromMap(e))
            .toList();

        if (response.isNotEmpty) {
          // logs with postgres
          // final logsCreate = LogsCreateRequestModel(
          //     createdBy: authResponse.user!.id,
          //     detail: '${response.first.name} : $logActionLogin');
          // Log.loga(title, 'signInWithEmailPassword:: ${logsCreate.toJson()}');
          // final resultCreateLog = await LogsService().createLogs(logsCreate);
          // logs with nhost
          await graphqlClient.mutate(
            MutationOptions(document: createLogs, variables: {
              'logs': LogsCreateRequestModel(
                  createdBy: authResponse.user!.id,
                  detail: '${response.first.name} : $logActionLogin')
            }),
          );
          // Log.loga(title, 'signInWithEmailPassword:: logs: ${mutationResult}');
        }
        return true;
      }
      return false;
      // return authResponse.user != null ? true : false;
    } on ApiException catch (e) {
      log('${e.responseBody['message']}');
      signInError.value = '${e.responseBody['message']}';
      return false;
    }
  }
}
