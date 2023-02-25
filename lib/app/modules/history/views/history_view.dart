import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/constant.dart';
import '../controllers/history_controller.dart';

class HistoryView extends StatelessWidget {
  HistoryView({Key? key}) : super(key: key);
  HistoryController controller = Get.put(HistoryController());

  final scrollBarController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการสั่งซื้อ'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'ค้นหา',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    controller.listLogs();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Scrollbar(
                thumbVisibility: true,
                controller: scrollBarController,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(defaultPadding),
                  controller: scrollBarController,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            controller.logsList[index].detail,
                            style: const TextStyle(
                              // color: darkBlueColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(DateFormat("dd-MM-yyyy hh:mm:ss")
                              .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                                  controller.logsList[index].createdAt
                                      .toString()))),
                        ),
                        const Divider(
                          height: 5.0,
                        ),
                      ],
                    );
                  },
                  itemCount: controller.logsList.length,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
