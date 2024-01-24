import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/color/SqThemeData.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:sq_subsonic_desktop/page/play_page/lyric/SqLyricUI.dart';

class PlayPage extends StatefulWidget {
  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final serviceController = Get.put(ServiceController());
  var lyricUI = SqLyricUI();

  HotKey _hotKey = HotKey(
    KeyCode.escape,
    // modifiers: [KeyModifier.alt, KeyModifier.control],
    // 设置热键范围（默认为 HotKeyScope.system）
    scope: HotKeyScope.inapp, // 设置为应用范围的热键。
  );
  var nowDuration = 0.obs;

  @override
  void initState() {
    // 对于热重载，`unregisterAll()` 需要被调用。
    _hotKey = HotKey(
      KeyCode.escape,
      // 设置热键范围（默认为 HotKeyScope.system）
      scope: HotKeyScope.inapp, // 设置为应用范围的热键。
    );
    hotKeyManager.register(
      _hotKey,
      keyDownHandler: (hotKey) {
        Navigator.of(context).pop();
        print('onKeyDown+${hotKey.toJson()}');
        hotKeyManager.unregister(_hotKey);
      },
    );
    serviceController.player.onPositionChanged.listen((event) {
      nowDuration.value = event.inMilliseconds.toInt();
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode?dark_background_Colors:light_background_Colors,
        child: Blur(
            blur: 60,
            blurColor: Theme.of(context).primaryColor,
            overlay: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          hotKeyManager.unregister(_hotKey);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(LineIcons.angleDown)),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Container(
                                      alignment: Alignment(0,0),
                                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Image.network(
                                          serviceController.musicImageUrl.value),
                                    )),
                                // Expanded(
                                //   flex: 1,
                                //   child: Container(),
                                // ),
                                Expanded(
                                    flex: 6,
                                    child: Container(
                                      // alignment: Alignment(-1,0),
                                      // margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              '名称：${serviceController.musicName
                                                  .value}',
                                              style: TextStyle(
                                                  color:Get.isDarkMode? dark_sub_text_Colors : light_sub_text_Colors,
                                                  fontSize: 20,
                                                  decoration: TextDecoration
                                                      .none),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              '歌手：${serviceController
                                                  .musicArtist.value}',
                                              style: TextStyle(
                                                  color: Get.isDarkMode? dark_sub_text_Colors : light_sub_text_Colors,
                                                  fontSize: 20,
                                                  decoration: TextDecoration
                                                      .none),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '专辑：${serviceController.musicAlubm
                                                  .value}',
                                              style: TextStyle(
                                                  color: Get.isDarkMode? dark_sub_text_Colors : light_sub_text_Colors,
                                                  fontSize: 20,
                                                  decoration: TextDecoration
                                                      .none),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                // Expanded(
                                //     flex: 1,
                                //     child:
                                // Expanded(
                                //     flex: 1,
                                //     child: Text(
                                //       serviceController.musicAlubm.value,
                                //       style: TextStyle(color: Colors.black,fontSize: 20),
                                //     )
                                // ),
                              ],
                            )
                        ),
                        Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Obx(() {
                                      return
                                        LyricsReader(
                                        padding: const EdgeInsets.all(8.0),
                                        position: nowDuration.value,
                                        lyricUi: lyricUI,
                                        model: LyricsModelBuilder.create()
                                            .bindLyricToMain(serviceController
                                            .musicLyric.value)
                                            .getModel(),
                                        playing: true,
                                        emptyBuilder: () =>
                                            Center(
                                              child: Text(
                                                "暂无歌词",
                                                style:
                                                lyricUI.getOtherMainTextStyle(),
                                              ),
                                            ),
                                        selectLineBuilder: (progress, confirm) {
                                          return Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    // LyricsLog.logD("点击事件");
                                                    confirm.call();
                                                    setState(() {
                                                      serviceController
                                                          .seekDuration(
                                                          (Duration(
                                                              milliseconds:
                                                              progress)));
                                                    });
                                                  },
                                                  icon: Icon(Icons.play_arrow,
                                                      color: Colors.redAccent)),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.redAccent),
                                                  height: 1,
                                                  width: double.infinity,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );


                                    })
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            child: Container(
                child: Image.network(
                  serviceController.musicImageUrl.value,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: double.maxFinite,
                ))));
  }
}
