import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class MainMenuController  with TrayListener , WindowListener{

  final TrayManager _trayManager = TrayManager.instance;
  final serviceController = Get.put(ServiceController());


  @override
  void onWindowClose() async {
    windowManager.hide();
  }

  void init() async{
    await windowManager.setPreventClose(true);
    windowManager.addListener(this);
    _trayManager.addListener(this);
    final String _iconPathWin = 'assets/logo/logo.ico';
    final String _iconPathOther = 'assets/logo/logo.png';
    await _trayManager.setIcon(_iconPathWin);
    Menu _menu = Menu(items: [
      MenuItem(label: '暂停/播放'),
      MenuItem(label: '下一曲'),
      MenuItem(label: '上一曲'),
      MenuItem(label: '关闭'),
    ]);
    _trayManager.setContextMenu(_menu);
  }
  @override
  void onTrayIconRightMouseDown() async {
    await _trayManager.popUpContextMenu();
  }
  @override
  void onTrayMenuItemClick(MenuItem menuItem) {

    switch (menuItem.label) {
      case '暂停/播放':
        if(serviceController.player.state == PlayerState.playing){
          serviceController.pause();
        }else if(serviceController.player.state == PlayerState.paused){
          serviceController.resume();
        }
        break;
        case '下一曲':
          serviceController.nextSilent();
        break;
      case '上一曲':
          serviceController.previousSilent();
        break;
      case '关闭':
        windowManager.destroy();
        // windowManager.close();
        break;
        // 该方法来自window_manager插件
      }
  }
  @override
  void onTrayIconMouseDown() {
    windowManager.show(); // 该方法来自window_manager插件
  }
}
