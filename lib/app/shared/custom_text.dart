import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  const CustomText({
    Key? key,
    this.text = '',
    this.size = 16,
    this.color = primaryColor,
    this.weight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!.tr,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
