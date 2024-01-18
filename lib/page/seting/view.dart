import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/typography/gf_typography.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_typography_type.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/color/ColrosUtils.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/left_widget/LeftController.dart';
import 'package:sq_subsonic_desktop/page/seting/widget/HotKeyText.dart';

import 'logic.dart';

class SetingPage extends StatelessWidget {
  SetingPage({Key? key}) : super(key: key);

  final logic = Get.put(SetingLogic());

  @override
  Widget build(BuildContext context) {
    var IPController = TextEditingController(text: logic.server_info_ip.value);
    LeftController leftController = Get.put(LeftController());
    var usernameController =
    TextEditingController(text: logic.server_info_username.value);
    var passwordController =
    TextEditingController(text:  logic.server_info_password.value);
    return Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: GetBuilder<SetingLogic>(
                  id: "open_global_hotkey_view",
                  builder: (logic) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            child: GFTypography(
                              text: '热键设置',
                              type: GFTypographyType.typo3,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: GFTypography(
                            text: '系统',
                            type: GFTypographyType.typo3,
                            showDivider: false,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // color: Colors.black26,
                                  child: GFTypography(
                                    text: '全局',
                                    type: GFTypographyType.typo3,
                                    showDivider: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                        activeColor: Colors.green,
                                        splashRadius: 0,
                                        inactiveThumbColor: Colors.black26,
                                        value: logic.open_global_hotkey.value,
                                        onChanged: (value) {
                                          logic.setGlobalHotkeyOpen(value!);
                                        }),
                                  )),
                              Expanded(
                                flex: 2,
                                child: Container(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: GFButton(
                            type: GFButtonType.outline,
                            borderShape: const RoundedRectangleBorder(
                              //边框圆角
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            blockButton: true,
                            // highlightColor:Colors.orange,
                            color: Colors.transparent,
                            buttonBoxShadow: true,
                            hoverColor: ColrosUtils.fromHex("#dcdcdc"),
                            animationDuration: Duration(milliseconds: 3),
                            hoverElevation: 0,
                            child: Obx(() {
                              return Text(
                                  logic.readOnly.value ? "编辑" : "确定");
                            }),
                            onPressed: () {
                              logic.setReadOnly();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GFButton(
                            type: GFButtonType.outline,
                            // shape: GFButtonShape.pills,
                            splashColor: Colors.blueAccent,
                            child: Text("重置快捷键"),
                            borderShape: const RoundedRectangleBorder(
                              //边框圆角
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            blockButton: true,
                            // highlightColor:Colors.orange,
                            color: Colors.transparent,
                            buttonBoxShadow: true,
                            hoverColor: ColrosUtils.fromHex("#dcdcdc"),
                            animationDuration: Duration(milliseconds: 3),
                            hoverElevation: 0,

                            onPressed: () {
                              logic.initSetConfig();
                              logic.onInit();
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: GFTypography(
                                        text: '暂停/播放：',
                                        type: GFTypographyType.typo4,
                                        showDivider: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: GFTypography(
                                        text: '下一曲：',
                                        type: GFTypographyType.typo4,
                                        showDivider: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: GFTypography(
                                        text: '上一曲：',
                                        type: GFTypographyType.typo4,
                                        showDivider: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: GFTypography(
                                        text: '音量+：',
                                        type: GFTypographyType.typo4,
                                        showDivider: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: GFTypography(
                                        text: '音量-：',
                                        type: GFTypographyType.typo4,
                                        showDivider: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: GetBuilder<SetingLogic>(
                                      id: "hotkey_view",
                                      builder: (logic) {
                                        return Column(
                                          children: [
                                            Expanded(
                                                child: HotKeyText("hotkey",
                                                    "playMusic", "inapp")),
                                            Expanded(
                                                child: HotKeyText("hotkey",
                                                    "nextMusic", "inapp")),
                                            Expanded(
                                                child: HotKeyText("hotkey",
                                                    "prevMusic", "inapp")),
                                            Expanded(
                                                child: HotKeyText("hotkey",
                                                    "volumeAdd", "inapp")),
                                            Expanded(
                                                child: HotKeyText("hotkey",
                                                    "volumeSub", "inapp")),
                                          ],
                                        );
                                      })),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: GetBuilder<SetingLogic>(
                                      id: "global_hotkey_view",
                                      builder: (logic) {
                                        return Column(
                                          children: [
                                            Expanded(
                                                child: HotKeyText(
                                                    "global_hotkeys",
                                                    "playMusic",
                                                    "system")),
                                            Expanded(
                                                child: HotKeyText(
                                                    "global_hotkeys",
                                                    "nextMusic",
                                                    "system")),
                                            Expanded(
                                                child: HotKeyText(
                                                    "global_hotkeys",
                                                    "prevMusic",
                                                    "system")),
                                            Expanded(
                                                child: HotKeyText(
                                                    "global_hotkeys",
                                                    "volumeAdd",
                                                    "system")),
                                            Expanded(
                                                child: HotKeyText(
                                                    "global_hotkeys",
                                                    "volumeSub",
                                                    "system")),
                                          ],
                                        );
                                      })),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 6,
                child: GetBuilder<ServiceController>(
                    id:"show_config_view",
                    builder: (serviceController) {
                  return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GFTypography(
                              text: '列表设置',
                              type: GFTypographyType.typo3,
                            ),),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: GFTypography(
                                        text: '歌手直接打开音乐',
                                        type: GFTypographyType.typo4,
                                        showDivider: false
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                      activeColor: Colors.green,
                                      splashRadius: 0,
                                      inactiveThumbColor: Colors.black26,
                                      value: serviceController.openArtistToMusic.value,
                                      onChanged: (value) {
                                        serviceController.openArtistToMusic.value = value;
                                        logic.setServeConfig("open_artist_to_music", value.toString());
                                        serviceController.update(["show_config_view"]);
                                      }),),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: GFTypography(
                                        text: '显示歌手图片',
                                        type: GFTypographyType.typo4,
                                        showDivider: false
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                      activeColor: Colors.green,
                                      splashRadius: 0,
                                      inactiveThumbColor: Colors.black26,
                                      value: serviceController.showArtistImage.value,
                                      onChanged: (value) {
                                        serviceController.showArtistImage.value = value;
                                        logic.setServeConfig("show_artist_image", value.toString());
                                        serviceController.update(["show_config_view"]);
                                      }),),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: GFTypography(
                                        text: '显示专辑图片',
                                        type: GFTypographyType.typo4,
                                        showDivider: false
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                      activeColor: Colors.green,
                                      splashRadius: 0,
                                      inactiveThumbColor: Colors.black26,
                                      value: serviceController.showAlbumImage.value,
                                      onChanged: (value) {
                                        serviceController.showAlbumImage.value = value;
                                        logic.setServeConfig("show_album_image", value.toString());
                                        serviceController.update(["show_config_view"]);
                                      }),),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: GFTypography(
                                        text: '显示音乐图片',
                                        type: GFTypographyType.typo4,
                                        showDivider: false
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                      activeColor: Colors.green,
                                      splashRadius: 0,
                                      inactiveThumbColor: Colors.black26,
                                      value: serviceController.showSongImage.value,
                                      onChanged: (value) {
                                        serviceController.showSongImage.value = value;
                                        logic.setServeConfig("show_song_image", value.toString());
                                        serviceController.update(["show_config_view"]);
                                      }),),
                              ],
                            ),
                          ),

                        ],
                      )
                  );
                })),
            Expanded(
              flex: 4,
              child: GetBuilder<SetingLogic>(
                  id: "service_view",
                  builder: (logic) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GFTypography(
                                  // text: '服务器设置：',
                                  child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "服务器设置:",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Icon(
                                            LineIcons.server,
                                            color: logic.sercer_check_status
                                                .value
                                                ? Colors.green
                                                : Colors.grey,
                                          )
                                        ],
                                      )),
                                  type: GFTypographyType.typo3,
                                ),
                              )
                            ],
                          ),
                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        child: Text("服务器IP"),
                                      )),
                                  Expanded(
                                      child: Container(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 1),
                                            ),
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: IPController,
                                        ),
                                      ))
                                ],
                              )),
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Container(
                                        child: Text("用户名"),
                                      )),
                                  Expanded(
                                      child: Container(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 1),
                                            ),
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: usernameController,
                                        ),
                                      ))
                                ],
                              )),
                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        child: Text("密码"),
                                      )),
                                  Expanded(
                                      child: Container(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 1),
                                            ),
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: passwordController,
                                        ),
                                      ))
                                ],
                              )),
                        ],
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  child: GFButton(
                    onPressed: () {
                      logic
                          .saveServerInfo(IPController.text,
                          usernameController.text, passwordController.text)
                          .then((value) {
                        print('dasdsadsad:${value}');
                        if (value) {
                          leftController.onInit();
                          showToast(
                            "保存完成，正在刷新",
                            context: context,
                            position: StyledToastPosition.center,
                          );
                        } else {
                          showToast(
                            "服务器检测错，请检查配置是否正确！",
                            context: context,
                            position: StyledToastPosition.center,
                          );
                        }
                      });
                    },
                    child: Text("保存"),
                  ),
                )),
            // Expanded(flex: 1, child: Container())
          ],
        ),
      ),
    );
  }
}
