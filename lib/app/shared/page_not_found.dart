import 'package:flutter/material.dart';

import 'constant.dart';
import 'custom_text.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "assets/images/404.png",
            width: 350,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "เกิดข้อผิดพลาดกับระบบ",
                size: 24,
                weight: FontWeight.bold,
                color: Colors.black.withOpacity(.7),
              )
            ],
          ),
        ],
      ),
    );
  }
}
