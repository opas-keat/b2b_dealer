import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/models/logs_service_model.dart';
import '../../shared/utils/log_util.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class LogsService {
  final title = "LogsService";

  Future<LogsCreateResponseModel?> createLogs(
    LogsCreateRequestModel logsCreateRequestModel,
  ) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return LogsCreateResponseModel.withError(
          statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }
    Log.loga(title, 'createLogs:: ${logsCreateRequestModel.toString()}');
    String url = '${Api.baseUrlLogs}${ApiEndPoints.logs}/';
    try {
      final result = await apiUtils.post(
        url: url,
        data: logsCreateRequestModel.toJson(),
      );
      Log.loga(title, 'createLogs:: ${result.data['status_code']}');
      if (result.data['status_code'] == 200) {
        return LogsCreateResponseModel.fromJson(result.data);
      }
      return LogsCreateResponseModel.withError(
          statusCode: CODE_RESPONSE_NULL, msg: "");
    } catch (e) {
      return LogsCreateResponseModel.withError(
          statusCode: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }
}
