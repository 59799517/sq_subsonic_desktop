import 'package:audioplayers/audioplayers.dart';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mmoo_lyric/lyric.dart';
import 'package:mmoo_lyric/lyric_controller.dart';
import 'package:mmoo_lyric/lyric_util.dart';
import 'package:mmoo_lyric/lyric_widget.dart';
import 'package:sq_subsonic_desktop/color/SqThemeData.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:sq_subsonic_desktop/page/play_page/lyric/SqLyricUI.dart';

class PlayPage extends StatefulWidget {
  late Duration nowDuration;


  PlayPage(this.nowDuration);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final serviceController = Get.put(ServiceController());
  // var lyricUI = SqLyricUI();
  var lyricWidget;
  var lyriccontroller = LyricController(draggingTimerDuration: Duration(milliseconds: 500));
  HotKey _hotKey = HotKey(
    KeyCode.escape,
    // modifiers: [KeyModifier.alt, KeyModifier.control],
    // 设置热键范围（默认为 HotKeyScope.system）
    scope: HotKeyScope.inapp, // 设置为应用范围的热键。
  );

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
    super.initState();
    serviceController.player.onPositionChanged.listen((event) {
      setState(() {
        widget.nowDuration = event;
        lyriccontroller.progress = widget.nowDuration;
      });
    });
    List<Lyric> formatLyric ;
    var lyric = Lyric(lyric: "暂无歌词", startTime: Duration(hours: 200),endTime: Duration(hours: 200));

    try {
      formatLyric= LyricUtil.formatLyric(serviceController.musicLyric.value.isEmpty?'[00:00.00] 暂无歌词！':serviceController.musicLyric.value);
    } catch (e) {
    //   var lyric2 = Lyric(lyric: serviceController.musicLyric.value, startTime: Duration(hours: 200),endTime: Duration(hours: 200));
    // var showlss =  serviceController.musicLyric.value.isEmpty?lyric:lyric2;
      formatLyric = [lyric];
    }

     lyricWidget = LyricWidget(
      size: Size(double.infinity, double.infinity),
      lyrics: formatLyric,
      controller: lyriccontroller,
    );


  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(id:"play_page_musicinfo",builder: (logic) {
      return Container(
          color: Get.isDarkMode
              ? dark_background_Colors
              : light_background_Colors,
          child: Blur(
              blur: 60,
              blurColor: Theme
                  .of(context)
                  .primaryColor,
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
                          icon: Icon(LineIcons.angleDown,
                            color: Get.isDarkMode ? Colors.white : Colors
                                .black,)),
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
                                          alignment: Alignment(0, 0),
                                          margin: EdgeInsets.fromLTRB(
                                              30, 0, 0, 0),
                                          child:
                                          CachedNetworkImage(
                                            imageUrl: logic
                                                .musicImageUrl.value,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget: (context, url,
                                                error) =>
                                                Image.asset(
                                                    "assets/image/response.png"),
                                          )
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
                                                '名称：${logic
                                                    .musicName
                                                    .value}',
                                                style: TextStyle(
                                                    color: Get.isDarkMode
                                                        ? dark_sub_text_Colors
                                                        : light_sub_text_Colors,
                                                    fontSize: 20,
                                                    decoration: TextDecoration
                                                        .none),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(20),
                                              child: Text(
                                                '歌手：${logic
                                                    .musicArtist.value}',
                                                style: TextStyle(
                                                    color: Get.isDarkMode
                                                        ? dark_sub_text_Colors
                                                        : light_sub_text_Colors,
                                                    fontSize: 20,
                                                    decoration: TextDecoration
                                                        .none),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '专辑：${logic
                                                    .musicAlubm
                                                    .value}',
                                                style: TextStyle(
                                                    color: Get.isDarkMode
                                                        ? dark_sub_text_Colors
                                                        : light_sub_text_Colors,
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
                                      child:lyricWidget==null?Container(child: Text('暂无歌词')):lyricWidget!,


                                          // LyricsReader(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   position: widget.nowDuration.inMilliseconds,
                                          //   lyricUi: lyricUI,
                                          //   model: LyricsModelBuilder.create()
                                          //       .bindLyricToMain(
                                          //       logic
                                          //           .musicLyric.value)
                                          //       .getModel(),
                                          //   playing: logic.player.state == PlayerState.playing,
                                          //   emptyBuilder: () =>
                                          //       Center(
                                          //         child: Text(
                                          //           "暂无歌词",
                                          //           style:
                                          //           lyricUI
                                          //               .getOtherMainTextStyle(),
                                          //         ),
                                          //       ),
                                          //   selectLineBuilder: (progress,
                                          //       confirm) {
                                          //     return Row(
                                          //       children: [
                                          //         IconButton(
                                          //             onPressed: () {
                                          //               // LyricsLog.logD("点击事件");
                                          //               confirm.call();
                                          //               setState(() {
                                          //                 logic
                                          //                     .seekDuration(
                                          //                     (Duration(
                                          //                         milliseconds:
                                          //                         progress)));
                                          //               });
                                          //             },
                                          //             icon: Icon(
                                          //                 Icons.play_arrow,
                                          //                 color: Colors
                                          //                     .redAccent)),
                                          //         Expanded(
                                          //           child: Container(
                                          //             decoration: BoxDecoration(
                                          //                 color: Colors
                                          //                     .redAccent),
                                          //             height: 1,
                                          //             width: double.infinity,
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     );
                                          //   },
                                          // )

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
                  child:
                  CachedNetworkImage(
                    imageUrl: logic.musicImageUrl.value,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/image/response.png"),
                  )
              )));
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('lyricWidget', lyricWidget));
  }
}
