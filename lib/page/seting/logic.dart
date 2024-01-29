
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:material_dialogs/material_dialogs.dart';

import 'dart:convert' as convert;

import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/utils/SubsonicApi.dart';

class SetingLogic extends GetxController {
  String title = "设置";
  var serviceController = Get.put(ServiceController());


//服务器信息
  var server_info_ip = "".obs;
  var server_info_username = "".obs;
  var server_info_password = "".obs;




  var sercer_check_status= false.obs;

  //开启全局快捷键
  var open_global_hotkey = false.obs;

  //开启快捷键编辑
  var readOnly = true.obs;

  //快捷键显示
  RxString hotkey_config_playMusic = "".obs;
  RxString hotkey_config_nextMusic = "".obs;
  RxString hotkey_config_prevMusic = "".obs;
  RxString hotkey_config_volumeAdd = "".obs;
  RxString hotkey_config_volumeSub = "".obs;

  RxString global_hotkey_config_playMusic = "".obs;
  RxString global_hotkey_config_nextMusic = "".obs;
  RxString global_hotkey_config_prevMusic = "".obs;
  RxString global_hotkey_config_volumeAdd = "".obs;
  RxString global_hotkey_config_volumeSub = "".obs;

  @override
  void onInit() {
    super.onInit();
    getGlobalHotkeysOpenConfig().then((value) {
      if (value == null) {
        initSetConfig();
      }
      open_global_hotkey.value = bool.parse(value);
      update(["open_global_hotkey_view"]);
    });
    getHotkeyConfig().then((value) {
      value.forEach((key, value) {
        var hotKey = HotKey.fromJson(convert.jsonDecode(value));
        var join = hotKey.modifiers?.map((e) => e.keyLabel).join('+');
        if (join != null || join != '') {
          join = (join! + "+");
          join += hotKey.keyCode.keyLabel;
        } else {
          join = hotKey.keyCode.keyLabel;
        }
        if (key == 'playMusic') {
          hotkey_config_playMusic.value = join;
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            serviceController.player.state== PlayerState.playing ? serviceController.pause() : serviceController.resume();
          });
        } else if (key == 'nextMusic') {
          hotkey_config_nextMusic.value = join;
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            serviceController.nextSilent();
          });
        } else if (key == 'prevMusic') {
          hotkey_config_prevMusic.value = join;
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            serviceController.previousSilent();
          });
        } else if (key == 'volumeAdd') {
          hotkey_config_volumeAdd.value = join;
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            double getvolume = serviceController.getvolume();
            getvolume+=0.1;
            if(getvolume>1){
              getvolume=1;
            }
            serviceController.setvolume(getvolume);
          });
        } else if (key == 'volumeSub') {
          hotkey_config_volumeSub.value = join;
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            double getvolume = serviceController.getvolume();
            getvolume-=0.1;
            if(getvolume<0){
              getvolume=0;
            }
            serviceController.setvolume(getvolume);
          });
        }
      });
    });
      getGlobalHotkeysConfig().then((value)   {
        value.forEach((key, value) {
          var hotKey = HotKey.fromJson(convert.jsonDecode(value));
          var join = hotKey.modifiers?.map((e) => e.keyLabel).join('+');
          if (join != null || join != '') {
            join = (join! + "+");
            join += hotKey.keyCode.keyLabel;
          } else {
            join = hotKey.keyCode.keyLabel;
          }
          if (key == 'playMusic') {
            global_hotkey_config_playMusic.value = join;
            if(open_global_hotkey.value){
              hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
                serviceController.player.state== PlayerState.playing ? serviceController.pause() : serviceController.resume();
              });
            }
          } else if (key == 'nextMusic') {
            if(open_global_hotkey.value){
              hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
                serviceController.nextSilent();
              });
            }

            global_hotkey_config_nextMusic.value = join;
          } else if (key == 'prevMusic') {
            if(open_global_hotkey.value){
              hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
                serviceController.previousSilent();
              });
            }

            global_hotkey_config_prevMusic.value = join;
          } else if (key == 'volumeAdd') {
            if(open_global_hotkey.value){
              hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
                double getvolume = serviceController.getvolume();
                getvolume+=0.1;
                if(getvolume>1){
                  getvolume=1;
                }
                serviceController.setvolume(getvolume);
              });
            }
            global_hotkey_config_volumeAdd.value = join;

          } else if (key == 'volumeSub') {
            if(open_global_hotkey.value){
              hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
                double getvolume = serviceController.getvolume();
                getvolume-=0.1;
                if(getvolume<0){
                  getvolume=0;
                }
                serviceController.setvolume(getvolume);
              });
            }
            global_hotkey_config_volumeSub.value = join;
          }
        });
      });


    update(["hotkey_view", "global_hotkey_view","open_global_hotkey_view","open_global_hotkey_view"]);
   getServiceInfo().then((serviceInfo) {
     print('$serviceInfo');
     if (serviceInfo!= null) {
       try {
         server_info_ip.value = serviceInfo["ip"];
         server_info_username.value = serviceInfo["username"];
         server_info_password.value = serviceInfo["password"];
       } catch (e) {
         server_info_ip.value ='';
         server_info_username.value='';
         server_info_password.value ='';
       }
     }
     update(["service_view", "global_hotkey_view","open_global_hotkey_view"]);
    });
    checkService();
  }

  initSetConfig() {
    //热键设置
    Hive.openBox('set_hotkey').then((box) => {
      box.putAll({
        "playMusic":
        '{"keyCode":"keyP","modifiers":["control"],"identifier":"6396a2d3-12fe-4270-866b-d16ae25740e7","scope":"inapp"}',
        "nextMusic":
        '{"keyCode":"arrowRight","modifiers":["control"],"identifier":"43ba8add-5ab4-4a13-b96d-ac369fde561f","scope":"inapp"}',
        "prevMusic":
        '{"keyCode":"arrowLeft","modifiers":["control"],"identifier":"30e88817-e38f-44e4-b518-8dd094572af0","scope":"inapp"}',
        "volumeAdd":
        '{"keyCode":"arrowUp","modifiers":["control"],"identifier":"d0735d06-3907-4954-a1b8-e9e780846261","scope":"inapp"}',
        "volumeSub":
        '{"keyCode":"arrowDown","modifiers":["control"],"identifier":"d35294c9-de2d-4354-ac80-1b2b8c6498e7","scope":"inapp"}',
      })
    });
    // 全局热键
    Hive.openBox('set_global_hotkeys').then((box) => {
      box.putAll({
        "playMusic":
        '{"keyCode":"keyP","modifiers":["control","alt"],"identifier":"6fee7947-a752-4830-b41a-d863de642e32","scope":"system"}',
        "nextMusic":
        '{"keyCode":"arrowRight","modifiers":["control","alt"],"identifier":"a1640847-4bbf-487b-b212-060795730ef8","scope":"system"}',
        "prevMusic":
        '{"keyCode":"arrowLeft","modifiers":["control","alt"],"identifier":"8d82bef8-e59c-4b81-9a26-4eb3f013bdcf","scope":"system"}',
        "volumeAdd":
        '{"keyCode":"arrowUp","modifiers":["control","alt"],"identifier":"d9d06879-57fc-4955-b2fd-1c06806a6e35","scope":"system"}',
        "volumeSub":
        '{"keyCode":"arrowDown","modifiers":["control","alt"],"identifier":"8d3372c7-1275-48f5-9bc6-8716cffa3682","scope":"system"}',
      })
    });
    Hive.openBox('set_server_config').then((box) => {
      //全局快捷键
      box.put("global_hotkeys_set_open", "false"),
      //歌手直接打开音乐
      box.put("open_artist_to_music", "false"),
      // 开机自动播放（暂时不做这个按钮）
      box.put("open_auto_play", "false"),
      //显示专辑图片
      box.put("show_album_image", "false"),
      //显示歌手图片
      box.put("show_artist_image", "false"),
      //显示歌曲图片
      box.put("show_song_image", "false"),
      //主题
      box.put("system_theme", "light"),
      //当前登录用户名称
      box.put("service_username", "SQ"),
      box.put("plug_open", "false"),
      box.put("plug_url", "http://127.0.0.1:8900"),
      box.put("plug_username", "admin"),
      box.put("plug_password", "admin"),
    });

    Hive.openBox('server_info').then((value) => {
      value.put("ip", "http://127.0.0.1:8900"),
      value.put("username", "admin"),
      value.put("password", "admin"),
    });
    Hive.openBox('server_info_subsonic_api_info').then((value) => {
      value.put("u", ""),
      value.put("p", ""),
      value.put("c", ""),
    });



  }

  getHotkey(String hotkeyType, String docName) async {
   var box = await  Hive.openBox('set_'+hotkeyType);
    return HotKey.fromJson(convert.jsonDecode( box.get(docName) ?? ''));
  }

  getHotkeyConfig() async {
    var box = await  Hive.openBox('set_hotkey');
    return box.toMap();
  }

  getGlobalHotkeysConfig() async {

    var box = await  Hive.openBox('set_global_hotkeys');
    return box.toMap();
  }

  getGlobalHotkeysOpenConfig() async {
    var box = await  Hive.openBox('set_server_config');
    return box.get("global_hotkeys_set_open");
  }

  void setReadOnly() {
    readOnly.value = !readOnly.value;
    hotKeyManager.unregisterAll();
    update(["hotkey_view", "global_hotkey_view"]);
  }

  void setHotkey(
      String hotkeyType, String docName, HotKey hotKey, String scope) async {
    var box = await  Hive.openBox('set_'+hotkeyType);
    if (scope == "inapp") {
      hotKey.scope = HotKeyScope.inapp;
    } else {
      hotKey.scope = HotKeyScope.system;
    }
    box.put(docName, convert.jsonEncode(hotKey.toJson()));
    print('json 字符串是：${box.toMap()}');
    onInit();
    update(["hotkey_view", "global_hotkey_view"]);
  }

  void openDialog(BuildContext context, String hotkeyType, String docName,
      {String scope = "inapp"}) async {
    if (readOnly.value) {
      return;
    }
    HotKey _hotKey = await getHotkey(hotkeyType, docName);
    Dialogs.materialDialog(
        msg: '',
        title: "请输入要修改的快捷键",
        customView: Blur(
            blurColor: Colors.white,
            blur: 0,
            child: Container(
              width: 30000,
              height: 400,
              child: Text("请输入要修改的快捷键",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.black)),
            ),
            overlay: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular((30)), // 圆角
                ),
                width: 30000,
                height: 400,
                child: HotKeyRecorder(
                  initalHotKey: _hotKey,
                  onHotKeyRecorded: (hotKey) {
                    _hotKey = hotKey;
                  },
                ))),
        color: Colors.white,
        context: context,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: '取消',
            // iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsOutlineButton(
            onPressed: () {
              setHotkey(hotkeyType, docName, _hotKey, scope);
              Navigator.pop(context);
            },
            text: '确定',
            // iconData: Icons.,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  RxString getHotKeyValue(String docName, String scope) {
    if (scope == "inapp") {
      if (docName == 'playMusic') {
        return hotkey_config_playMusic;
      } else if (docName == 'nextMusic') {
        return hotkey_config_nextMusic;
      } else if (docName == 'prevMusic') {
        return hotkey_config_prevMusic;
      } else if (docName == 'volumeAdd') {
        return hotkey_config_volumeAdd;
      } else if (docName == 'volumeSub') {
        return hotkey_config_volumeSub;
      }
    } else {
      if (docName == 'playMusic') {
        return global_hotkey_config_playMusic;
      } else if (docName == 'nextMusic') {
        return global_hotkey_config_nextMusic;
      } else if (docName == 'prevMusic') {
        return global_hotkey_config_prevMusic;
      } else if (docName == 'volumeAdd') {
        return global_hotkey_config_volumeAdd;
      } else if (docName == 'volumeSub') {
        return global_hotkey_config_volumeSub;
      }
    }
    return hotkey_config_playMusic;
  }



  setGlobalHotkeyOpen(bool openState) {
     open_global_hotkey.value =openState;
  Hive.openBox("set_server_config").then((box) => {
    box.put("global_hotkeys_set_open", open_global_hotkey.value.toString()),
  print('open_global_hotkey_view:${open_global_hotkey.value }')
  });
  if(open_global_hotkey.value){
    getGlobalHotkeysConfig().then((value)   {
      value.forEach((key, value) {
        var hotKey = HotKey.fromJson(convert.jsonDecode(value));
        if (key == 'playMusic') {
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            serviceController.player.state== PlayerState.playing ? serviceController.pause() : serviceController.resume();
          });
        } else if (key == 'nextMusic') {
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            serviceController.nextSilent();
          });
        } else if (key == 'prevMusic') {
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            serviceController.previousSilent();
          });
        } else if (key == 'volumeAdd') {
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            double getvolume = serviceController.getvolume();
            getvolume+=0.1;
            if(getvolume>1){
              getvolume=1;
            }
            serviceController.setvolume(getvolume);
          });
        } else if (key == 'volumeSub') {
          hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
            double getvolume = serviceController.getvolume();
            getvolume-=0.1;
            if(getvolume<0){
              getvolume=0;
            }
            serviceController.setvolume(getvolume);
          });
        }
      });
    });
  }else{
    getGlobalHotkeysConfig().then((value)   {
      value.forEach((key, value) {
        var hotKey = HotKey.fromJson(convert.jsonDecode(value));
        hotKeyManager.unregister(hotKey);
      });
    });
  }


  update(["open_global_hotkey_view"]);
  }


   getServiceInfo() async{
    var box = await Hive.openBox("server_info");
    return box.toMap();
  }
  savePlugInfo(String ip,String username,String password) async {
    var box = await Hive.openBox("set_server_config");
    box.put("plug_open", "false");
    box.put("plug_url",ip);
    box.put("plug_username", username);
    box.put("plug_password", password);


  }


   saveServerInfo(String ip,String username,String password) async {
  //需要重新登录
     var buildCheckiRequest = SubsonicApi.buildCheckiRequest(username,password);
    var result = await SubsonicApi.checkingServer(buildCheckiRequest,ip);
    if(result == null){
      return false;
    }
     var box = await Hive.openBox("server_info");
     box.put("ip", ip);
     box.put("username", username);
     box.put("password", password);

    var result2 = result["subsonic-response"]["status"];
    if(result2 == "ok"){

      var box2 = await Hive.openBox("server_info_subsonic_api_info");
      box2.putAll(buildCheckiRequest);
      sercer_check_status.value=true;
      update(["service_view"]);
      Map<String, dynamic > userinfo = await SubsonicApi.getUserRequest();

      var box3 = await Hive.openBox("set_server_config");
      box3.put("service_username", userinfo['subsonic-response']['user']['username']);
      return true;
    }
    return false;
  }
  checkService() async {
    var box2 = await Hive.openBox("server_info_subsonic_api_info");
    Map<String, dynamic>? future  = box2.toMap().cast<String, dynamic>();
    var box = await Hive.openBox("server_info");

    Map<String, dynamic>? server_info = box.toMap().cast<String, dynamic>();
    var ip = server_info?["ip"];
    if(future==null||server_info==null||ip==null){
      sercer_check_status.value=false;
      ip='';
      box2.clear();
    }
    var checkingServer = await SubsonicApi.checkingServer(future!,ip);
    if(checkingServer == null){
      sercer_check_status.value=false;
      box2.clear();
    }

    Map<String, dynamic > userinfo = await SubsonicApi.getUserRequest();
    var box3 = await Hive.openBox("set_server_config");
    box3.put("service_username", userinfo['subsonic-response']['user']['username']);

    try {
      var result2 = checkingServer["subsonic-response"]["status"];
      if(result2 == "ok"){
        sercer_check_status.value=true;
      }
    } catch (e) {
      sercer_check_status.value=false;
    }

    update(["service_view"]);
  }
  final Map<KeyModifier, String> _knownKeyLabels = <KeyModifier, String>{
    KeyModifier.capsLock: '⇪',
    KeyModifier.shift: '⇧',
    KeyModifier.control: (!kIsWeb && Platform.isMacOS) ? '⌃' : 'Ctrl',
    KeyModifier.alt: (!kIsWeb && Platform.isMacOS) ? '⌥' : 'Alt',
    KeyModifier.meta: (!kIsWeb && Platform.isMacOS) ? '⌘' : '⊞',
    KeyModifier.fn: 'fn',
  };


  setServeConfig(String config_name,String config_value) async{
    var box = await Hive.openBox("set_server_config");
    box.put(config_name, config_value);
    update(["set_server_config_view"]);
  }



}
