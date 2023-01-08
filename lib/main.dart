import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhost_flutter_graphql/nhost_flutter_graphql.dart';

import 'app/routes/app_pages.dart';
import 'app/shared/constant.dart';
import 'app/shared/page_not_found.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //nhost
  nhostClient = NhostClient(backendUrl: backendUrl);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NhostGraphQLProvider(
      nhostClient: nhostClient,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        title: "PPSW DEALER",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        unknownRoute: GetPage(
          name: "/not-found",
          page: () => const PageNotFound(),
          transition: Transition.noTransition,
        ),
        theme: ThemeData(
          useMaterial3: false,
          textTheme: GoogleFonts.promptTextTheme(),
          primaryColor: primaryColor,
          primaryColorDark: primaryLightColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: accentColor,
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
