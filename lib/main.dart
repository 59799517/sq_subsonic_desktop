import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/color/SqFontIcons.dart';
import 'package:sq_subsonic_desktop/page/controller/MainMenuController.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/controller/entity/LoopTypeType.dart';
import 'package:sq_subsonic_desktop/page/left_widget/LeftWidge.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/widget/SqIconButton.dart';
import 'package:sq_subsonic_desktop/page/play_page/PlayPage.dart';
import 'package:sq_subsonic_desktop/page/right_widget/RightWidget.dart';
import 'package:sq_subsonic_desktop/page/seting/logic.dart';
import 'package:sq_subsonic_desktop/page/widget/BlockButtonWidget.dart';
import 'package:sq_subsonic_desktop/utils/DurationUtils.dart';
import 'package:path/path.dart' as p;
import 'package:window_manager/window_manager.dart';
import 'color/ColrosUtils.dart';

void main() async {
  runApp(const MyApp());
  var path = Directory.current.path;
  var context = p.Context();

  WidgetsFlutterBinding.ensureInitialized();
  var join = context.join(path, "config");
  await Hive.initFlutter(join);
  Hive.registerAdapter(ColorAdapter());
  await windowManager.ensureInitialized();

  var serviceController = Get.put(ServiceController());
  var setingLogic = Get.put(SetingLogic());
  setingLogic.checkService();
  setingLogic.initSetConfig();
  // // serviceController.onInit();
  MainMenuController().init();

  // String storageLocation = (await getApplicationDocumentsDirectory()).path;
  doWhenWindowReady(() {
    final win = appWindow;
    // 必须加上这一行。
    WidgetsFlutterBinding.ensureInitialized();
    const initialSize = Size(1200, 900);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "SqSubsonic";
    win.show();
  });
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'alittf'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child: Row(
            children: [LeftSide(), RightSide()],
          ),
        ),
      ),
    );
  }
}

// const sidebarColor = Color(0xFFF6A00C);
const sidebarColor = Colors.transparent;

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Container(
            color: ColrosUtils.fromHex("#f2f2f2"),
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                Expanded(
                    child: Container(
                  child: LeftWidge(),
                ))
              ],
            )));
  }
}

const backgroundStartColor = Colors.transparent;
const backgroundEndColor = Colors.transparent;
GlobalKey<State<StatefulWidget>> _historyKey = GlobalKey();

class RightSide extends StatefulWidget {
  @override
  State<RightSide> createState() => _RightSide();
}

class _RightSide extends State<RightSide> {
  final ServiceController serviceController = Get.put(ServiceController());

  final LayerLink layerLink = LayerLink();
  InteractiveSliderController controller = InteractiveSliderController(0.0);
  var nowDuration = 0.0;
  late Widget playbutton = IconButton(
      onPressed: () {
        showToast(
          "请选择一个歌曲进行播放",
          context: context,
          position: StyledToastPosition.center,
        );
      },
      icon: Icon(LineIcons.playCircle));

  void setPlayButton(PlayerState state) {
    setState(() {
      if (state == PlayerState.playing) {
        playbutton = IconButton(
            onPressed: () {
              serviceController.pause();
            },
            icon: Icon(LineIcons.pauseCircleAlt));
      } else if (state == PlayerState.paused) {
        playbutton = IconButton(
            onPressed: () {
              serviceController.resume();
            },
            icon: Icon(LineIcons.playCircle));
      } else if (state == PlayerState.stopped) {
        playbutton = IconButton(
            onPressed: () {
              showToast(
                "请选择一个歌曲进行播放",
                context: context,
                position: StyledToastPosition.center,
              );
            },
            icon: Icon(LineIcons.playCircle));
      }
    });
  }
  HotKey _hotKey = HotKey(
    KeyCode.space,
    // modifiers: [KeyModifier.alt, KeyModifier.control],
    // 设置热键范围（默认为 HotKeyScope.system）
    scope: HotKeyScope.inapp, // 设置为应用范围的热键。
  );
  @override
  void initState() {
    super.initState();
    var state = serviceController.player.state;
    hotKeyManager.register(
      _hotKey,
      keyDownHandler: (hotKey) {
        if(serviceController.player.state == PlayerState.playing){
          serviceController.pause();
        }else if(serviceController.player.state == PlayerState.paused){
          serviceController.resume();
        }
      },
    );

    setPlayButton(state);

    serviceController.player.onPositionChanged.listen((event) {
      setState(() {
        nowDuration = event.inSeconds.toDouble();
      });
    });
    serviceController.player.onPlayerStateChanged.listen((state) {
      setPlayButton(state);
    });
    serviceController.player.onPlayerComplete.listen((event) {
      if (serviceController.loopType.value == LoopType.single) {
        serviceController.seek(0);
        serviceController.resume();
      } else {
        serviceController.nextSilent();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: [0.0, 1.0]),
        ),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(child: MoveWindow()),
                  const WindowButtons()
                ],
              ),
            ),
            Expanded(child: RightWidget()),
            Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3,
                            thumbColor: Colors.orange,
                            activeTrackColor: Colors.green,
                            inactiveTrackColor: Colors.black26,
                            overlayColor: Colors.purple,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 5),
                          ),
                          child:
                              GetBuilder<ServiceController>(builder: (logic) {
                            return Slider(
                              value: nowDuration,
                              max: logic.musicDuration.value,
                              onChanged: (value) {
                                setState(() {
                                  nowDuration = value;
                                });
                              },
                              onChangeEnd: (value) {
                                serviceController.seek(value.toInt());
                              },
                            );
                          }),
                        )),
                    // Expanded(
                    //   flex: 4,
                    //   child: Container(
                    //     // color: Colors.purple,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         Text("${DurationUtils.formatDurationBySeconds(nowDuration.toInt())}/${DurationUtils.formatDurationBySeconds(serviceController.musicDuration.value.toInt())}")
                    //       ],
                    //
                    //     ),
                    //   )
                    // ),
                    Expanded(
                      flex: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                              flex: 4,
                              child: Ink(
                                child: InkWell(
                                  child: GetBuilder<ServiceController>(
                                      id: "musicImageUrl_view",
                                      builder: (logic) {
                                        try {
                                          return (logic.musicImageUrl.value.isEmpty)?Image.asset("assets/image/response.png"):
                                           GFImageOverlay(
                                            height: 300,
                                            width: 300,
                                            image: NetworkImage(
                                                logic.musicImageUrl.value),
                                          );
                                        } catch (e) {
                                          return Container();
                                        }
                                      }),
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 50),
                                        //跳转背景透明路由
                                        opaque: true,
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = Offset(0.0, 1.0);
                                          var end = Offset(0.0, 0.0);
                                          var tween =
                                              Tween(begin: begin, end: end);
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return PlayPage();
                                        }));
                                  },
                                ),
                              )),
                          Expanded(
                              child: Container(
                                // color: Colors.orange,
                                child: GetBuilder<ServiceController>(
                                    id: "musicName_view",
                                    builder: (logic) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("${logic.musicName.value}"),
                                          Text(logic.musicArtist.value),
                                        ],
                                      );
                                    }),
                              ),
                              flex: 5),
                          Expanded(
                              flex: 20,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<ServiceController>(
                                        id: "music_operation_view",
                                        builder: (logic) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        logic.previous(context);
                                                      },
                                                      icon: Icon(LineIcons
                                                          .stepBackward))),
                                              Expanded(
                                                  flex: 1, child: Container()),
                                              Expanded(
                                                flex: 1,
                                                child: playbutton,
                                              ),
                                              Expanded(
                                                  flex: 1, child: Container()),
                                              Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        logic.next(context);
                                                      },
                                                      icon: Icon(LineIcons
                                                          .stepForward))),
                                              Expanded(
                                                  flex: 1, child: Container()),
                                              Expanded(
                                                flex: 1,
                                                child: SqStarIconButton(
                                                    logic.musicID.value,
                                                    logic.isStar.value),
                                              ),
                                              Expanded(
                                                  flex: 1, child: Container()),
                                              Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: logic.loopType
                                                                .value ==
                                                            LoopType.playList
                                                        ? Icon(SqFontIcons
                                                            .iconXunhuan)
                                                        : logic.loopType
                                                                    .value ==
                                                                LoopType.random
                                                            ? Icon(SqFontIcons
                                                                .iconSuijisenlin)
                                                            : Icon(SqFontIcons
                                                                .iconA25px),
                                                    onPressed: () {
                                                      logic.setPlayListType();
                                                    },
                                                  )),
                                              Expanded(
                                                  flex: 1, child: Container()),
                                              Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                      // key: _historyKey,
                                                      onPressed: () {
                                                        showPopupWindow(
                                                          context,
                                                          gravity:
                                                              KumiPopupGravity
                                                                  .rightBottom,
                                                          // curve: Curves.elasticOut,
                                                          bgColor: Colors
                                                              .transparent,
                                                          clickOutDismiss: true,
                                                          clickBackDismiss:
                                                              true,
                                                          customAnimation:
                                                              false,
                                                          customPop: false,
                                                          customPage: false,
                                                          // targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
                                                          needSafeDisplay: true,
                                                          underStatusBar: true,
                                                          underAppBar: true,
                                                          offsetX: 0,
                                                          offsetY: 0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  100),
                                                          onShowStart: (pop) {
                                                            print("showStart");
                                                          },
                                                          onShowFinish: (pop) {
                                                            print("showFinish");
                                                          },
                                                          onDismissStart:
                                                              (pop) {
                                                            print(
                                                                "dismissStart");
                                                          },
                                                          onDismissFinish:
                                                              (pop) {
                                                            print(
                                                                "dismissFinish");
                                                          },
                                                          onClickOut: (pop) {
                                                            print("onClickOut");
                                                          },
                                                          onClickBack: (pop) {
                                                            print(
                                                                "onClickBack");
                                                          },
                                                          childFun: (pop) {
                                                            return Container(
                                                              key: GlobalKey(),
                                                              // padding: EdgeInsets.all(10),
                                                              height: 700,
                                                              width: 500,
                                                              color:
                                                                  Colors.white,
                                                              child: GetBuilder<
                                                                      ServiceController>(
                                                                  id:
                                                                      "playlist_view",
                                                                  builder:
                                                                      (logic) {
                                                                    return Blur(
                                                                      // borderRadius: BorderRadius.all(Radius.circular(100)),
                                                                      // blurColor: Colors.black26,
                                                                      child:
                                                                          Container(),
                                                                      overlay:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          // color: Colors.green ,// 背景色
                                                                          border: new Border
                                                                              .all(
                                                                              color: Colors.white12,
                                                                              width: 3),
                                                                          // border
                                                                          borderRadius:
                                                                              BorderRadius.circular((10)), // 圆角
                                                                        ),
                                                                        // margin: EdgeInsets.all(30.0),
                                                                        // padding:
                                                                        //     EdgeInsets.all(
                                                                        //         30.0),

                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Expanded(
                                                                                child: Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: BlockButtonWidget(
                                                                                      onPressed: () {
                                                                                        serviceController.clearPlaylist();
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      name: '清空全部',
                                                                                      icon: Icon(Icons.delete)),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                            Expanded(
                                                                              flex: 10,
                                                                              child: ListView.builder(
                                                                                itemBuilder: (BuildContext context, int index) {
                                                                                  return GFListTile(
                                                                                    title: Text("${logic.playlist.value[index].title}"),
                                                                                    subTitleText: logic.playlist.value[index].album,
                                                                                    avatar: GFAvatar(backgroundImage: NetworkImage(logic.playlist.value[index].coverArt), shape: GFAvatarShape.standard),
                                                                                    icon: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                          icon: Icon(
                                                                                            Icons.play_arrow,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            logic.jumpMusic(index);
                                                                                          },
                                                                                        ),
                                                                                        Container(
                                                                                          width: 20,
                                                                                        ),
                                                                                        IconButton(
                                                                                            onPressed: () {
                                                                                              logic.removePlayListAt(index);
                                                                                            },
                                                                                            icon: Icon(
                                                                                              Icons.delete,
                                                                                              color: Colors.red,
                                                                                            ))
                                                                                      ],
                                                                                    ),
                                                                                    onTap: () {
                                                                                      pop.dismiss(context);
                                                                                      logic.jumpMusic(index);
                                                                                      print('index $index');
                                                                                    },
                                                                                  );
                                                                                },
                                                                                itemCount: logic.playlist.value.length,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                          LineIcons.history))),
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 13,
                              child: Container(
                                // color: Colors.green,
                                // width: 100,
                                child: GetBuilder<ServiceController>(
                                    id: "volume_view",
                                    builder: (logic) {
                                      return Column(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child:
                                                        Icon(Icons.volume_up),
                                                  ),
                                                  Expanded(
                                                    flex: 40,
                                                    child: Slider(
                                                      value: serviceController
                                                          .player.volume,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          serviceController
                                                              .setvolume(value);
                                                        });
                                                      },
                                                      min: 0.0,
                                                      max: 1.0,
                                                      // label: "${serviceController.player.volume*100.truncate()}",
                                                      activeColor:
                                                          Colors.black87,
                                                      inactiveColor:
                                                          Colors.black26,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 6,
                                                      child: Text(
                                                          "${(serviceController.getvolume() * 100).truncate()}")),
                                                  Expanded(
                                                      flex: 13,
                                                      child: Container()),
                                                ],
                                              )),
                                        ],
                                      );
                                    }),
                              )),
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                        "${DurationUtils.formatDurationBySeconds(nowDuration.toInt())}/${DurationUtils.formatDurationBySeconds(serviceController.musicDuration.value.toInt())}"),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<Future<int?>> _showBasicModalBottomSheet(
      context, List<String> options) async {
    return showModalBottomSheet<int>(
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(options[index]),
                onTap: () {
                  print('index $index');
                  Navigator.of(context).pop();
                });
          },
          itemCount: options.length,
        );
      },
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
