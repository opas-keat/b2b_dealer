import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';

import '../shared/constant.dart';
import 'app_pages.dart';

class RouteGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return nhostClient.auth.currentUser != null
        ? null
        : RouteSettings(name: Routes.SIGNIN);
  }
}
