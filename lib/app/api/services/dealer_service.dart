import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/models/dealer_service_model.dart';
import '../../shared/utils/log_util.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

final title = "ApiService";

class DealerService {
  Future<DealerServiceResponse?> getDealerByCode(String dealerCode) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return DealerServiceResponse.withError(
          statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }

    String url =
        '${Api.baseUrlSystemLink}${ApiEndPoints.systemLinkDealers}/$dealerCode';
    try {
      final result = await apiUtils.get(url: url);
      Log.loga(title, 'getDealerByCode:: ${result.data['status_code']}');
      if (result.data['status_code'] == 200) {
        return DealerServiceResponse.fromJson(result.data);
      }
      return DealerServiceResponse.withError(
          statusCode: CODE_RESPONSE_NULL, msg: "");
    } catch (e) {
      return DealerServiceResponse.withError(
          statusCode: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }
}
