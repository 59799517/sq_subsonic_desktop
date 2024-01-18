import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/widget/RightTopBar.dart';

import '../left_widget/LeftController.dart';

class RightWidget extends StatefulWidget {
  @override
  State<RightWidget> createState() => _RightWidgetState();
}

class _RightWidgetState extends State<RightWidget> {

  ServiceController serviceController = Get.put(ServiceController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Container(
      // color: Colors.blueGrey,
      height: double.infinity,
      child: Column(children: [
        Expanded(
            flex: 1,
            child: Obx(() {
              return RightTopBar(serviceController.titleNmae.value);
            })),
        Expanded(
          flex: 19,
          child: Container(
            color: Colors.transparent,
            child: Container(
              child: Container(
                  child:
                  Obx(() {
                    return Container(child:
                    serviceController.showWidget.value
                    );
                  })
              ),
            ),
          ),
        ),
      ]),
      // color: Colors.amberAccent,
    );
  }
}
