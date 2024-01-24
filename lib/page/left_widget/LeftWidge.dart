import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/color/ColrosUtils.dart';
import 'package:sq_subsonic_desktop/color/SqThemeData.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';

import '../right_widget/RightWidget.dart';
import 'LeftController.dart';

class LeftWidge extends StatefulWidget {
  @override
  State<LeftWidge> createState() => _LeftWidgeState();
}

class _LeftWidgeState extends State<LeftWidge> {
  LeftController leftController = Get.put(LeftController());
  final serviceController = Get.put(ServiceController());

  RxList<Widget> listItems = RxList();


  //当前选择右侧
  var activeTab = 1.obs;


  @override
  void initState() {
    initListItemas(0);
    leftController.cutove(0);
    selectTab(0);
    super.initState();
  }

  initListItemas(int index) {
    List<Widget> baseItems = [
      Obx(() {
        return GFAvatar(
          radius: 40.0,
          child: Text(serviceController.loginName.value,style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)),
          // backgroundColor: Colors.transparent,
        );
      }),
      SizedBox(
        height: 30,
      ),
    ];

    listItems.value.clear();
    listItems.value.addAll(baseItems);
    listItems.value.add(ListTile(
      leading: Icon(LineIcons.music,color:  Get.isDarkMode?dark_text_Colors:light_text_Colors,),
      title: Text('单曲随机',style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)),
      selected: index == 0,
      onTap: () {
        leftController.cutove(0);
        selectTab(0);
      },
    ));
    listItems.value.add(ListTile(
      leading: Icon(LineIcons.user,color:  Get.isDarkMode?dark_text_Colors:light_text_Colors,),
      title: Text('全部歌手',style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)),
      selected: index == 1,
      onTap: () {
        leftController.cutove(1);
        selectTab(1);
      },
    ));
    listItems.value.add(ListTile(
      leading: Icon(LineIcons.compactDisc,color:  Get.isDarkMode?dark_text_Colors:light_text_Colors,),
      title: Text('全部专辑',style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)),
      selected: index == 2,
      onTap: () {
        selectTab(2);
        leftController.cutove(2);
      },
    ));
    listItems.value.add(ListTile(
      leading: Icon(Icons.settings,color:  Get.isDarkMode?dark_text_Colors:light_text_Colors,),
      title: Text('设置',style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)),
      selected: index == 3,
      onTap: () {
        leftController.cutove(3);
        selectTab(3);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      //   color: Get.isDarkMode?dark_background_Colors:light_background_Colors,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Material(
                  type: MaterialType.transparency,
                  child: Obx(() =>
                      Center(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return listItems[index];
                          },
                          itemCount: listItems.length,
                        ),
                      ))),
            ),
            Expanded(
              flex: 1,
              child: Divider(),
            ),
            Expanded(
              flex: 15,
              child: Material(
                type: MaterialType.transparency,
                child: GetBuilder<LeftController>(
                    id: "play_list_view",
                    builder: (logic) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return logic.SplayLists_Widget[index];
                        },
                        itemCount: logic.SplayLists_Widget.value.length,
                      );
                    }),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Card(
            //     child: Text("333333333333333"),
            //   ),
            // )
          ],
        ));
  }

  selectTab(int index) {
    setState(() {
      activeTab.value = index;
      initListItemas(index);
    });
  }
}
