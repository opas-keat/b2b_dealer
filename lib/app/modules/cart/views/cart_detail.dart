import 'package:flutter/material.dart';

import '../../../shared/constant.dart';
import 'payment_channel_widget.dart';

class CartDetailWidget extends StatelessWidget {
  CartDetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'คำสั่งซื้อที่ XXXX-YYYYYYYYYY',
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          'วันที่ 01/01/2023',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  helperText: 'ที่อยู่',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                child: PaymentChannelWidget(),
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  helperText: 'บริษัทขนส่ง',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    helperText: 'วันที่นัดส่งสินค้า',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: const [
            Expanded(
              child: Text(
                'รายการสินค้า',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
