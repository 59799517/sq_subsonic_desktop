import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/color/SqThemeData.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_album/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_album/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_artist/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_artist/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/view.dart';
import 'package:sq_subsonic_desktop/page/seting/view.dart';
import 'package:sq_subsonic_desktop/subsonic/models/PlayListResult.dart';
import 'package:sq_subsonic_desktop/utils/SubsonicApi.dart';

class LeftController extends GetxController {
  RxList<Widget> SplayLists_Widget = RxList();
  final playlistlogic = Get.put(PlayListByArtistLogic());
  final playListByAlbumLogic = Get.put(PlayListByAlbumLogic());
  final playListByMusicLogic = Get.put(PlayListByMusicLogic());

  final serviceController = Get.put(ServiceController());
  TextEditingController _updateController = TextEditingController();

  @override
  void onInit() {
    getPlayLists();
    super.onInit();
  }

  ///切换
  cutove(int index) {
    if (index == 0) {
      serviceController.titleNmae.value = "单曲随机";
      random();
    } else if (index == 1) {
      serviceController.titleNmae.value = "全部歌手";
      artists();
    } else if (index == 2) {
      playListByAlbumLogic.turn_page.value = true;
      serviceController.titleNmae.value = "全部专辑";
      albums();
    } else if (index == 3) {
      serviceController.titleNmae.value = "设置";
      serviceController.showWidget.value = Container(child: SetingPage());
    } else {
      serviceController.titleNmae.value = "空页面";
      serviceController.showWidget.value =
          Container(child: Text("这啥都没有你咋进来的"));
    }
    update(["play_list_view", "right_widget"]);
  }

  random() async {
    playListByMusicLogic.turn_page.value = false;
    var search = await playListByMusicLogic.random();
    serviceController.showWidget.value =
        Container(child: PlayListByMusicPage(search));

  }

  artists() async {
    List<Widget> buildArtistsListView = await playlistlogic
        .buildArtistsListView();
    serviceController.showWidget.value = Container(
      child: PlayListByArtistPage(buildArtistsListView),
    );
    update(["right_widget"]);
  }

  albums() async {
    List<Widget> buildAlbumsListView = await playListByAlbumLogic
        .buildAlbumsListView();
    serviceController.showWidget.value = Container(
      child: PlayListByAlbumPage(
          buildAlbumsListView, PlayListByAlbumPageType.albumsList),
    );
    update(["right_widget",'play_list_view']);
  }

  cutovetoArtistPage() async {
    serviceController.titleNmae.value = "收藏-歌手";
    List<Widget> data = await playlistlogic.buildStarListView();
    serviceController.showWidget.value = Container(
      child: PlayListByArtistPage(data),
    );
    update(["right_widget",'play_list_view']);
    getPlayLists();
  }

  cutovetoAlubmPage() async {
    serviceController.titleNmae.value = "收藏-专辑";
    List<Widget> data = await playListByAlbumLogic.buildStarListView();
    serviceController.showWidget.value = Container(
      child: PlayListByAlbumPage(data, PlayListByAlbumPageType.none),
    );
    update(["right_widget",'play_list_view']);
    getPlayLists();
  }

  cutovetoMusicPage() async {
    serviceController.titleNmae.value = "收藏-单曲";
    playListByMusicLogic.turn_page.value = false;
    var data = await playListByMusicLogic.buildStarListView();
    serviceController.showWidget.value =
        Container(child: PlayListByMusicPage(data));
    update(["right_widget",'play_list_view']);
    getPlayLists();
  }

  getStar() {
    SplayLists_Widget.clear();
    SplayLists_Widget.insert(
        0,
        ListTile(
          leading: Icon(Icons.star_rate_outlined,color:  Get.isDarkMode?dark_text_Colors:light_text_Colors,),
          title: Text("收藏",style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors),),
          subtitle: Text("单曲",style: TextStyle(color:  Get.isDarkMode?dark_sub_text_Colors:light_sub_text_Colors)),
          onTap: () {
            cutovetoMusicPage();
          },
        ));
    SplayLists_Widget.insert(
        0,
        ListTile(
          leading: Icon(Icons.star_rate_outlined,color:  Get.isDarkMode?dark_text_Colors:light_text_Colors,),
          title: Text("收藏",style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)),
          subtitle: Text("专辑",style: TextStyle(color:  Get.isDarkMode?dark_sub_text_Colors:light_sub_text_Colors)),
          onTap: () {
            cutovetoAlubmPage();
          },
        ));
    SplayLists_Widget.insert(
        0,
        ListTile(
          leading: Icon(Icons.star_rate_outlined,color:  Get.isDarkMode?dark_text_Colors:light_text_Colors,),
          title: Text("收藏",style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors),),
          subtitle: Text("歌手",style: TextStyle(color:  Get.isDarkMode?dark_sub_text_Colors:light_sub_text_Colors)),
          onTap: () {
            cutovetoArtistPage();
          },
        ));
    update(["play_list_view"]);

  }

  getPlayLists() async{
    getStar();
    var res =await  SubsonicApi.playListsRequest();

    try {
      if (res.subsonicResponse?.status == "ok") {
              serviceController.server_playLists_info_list.value.clear();
              res.subsonicResponse!.playlists!.playlist!.forEach((element) {
                serviceController.server_playLists_info_list.value.add(element);
                SplayLists_Widget.add(ListTile(
                  leading: Icon(LineIcons.clipboardList,color: Get.isDarkMode?dark_text_Colors:light_text_Colors,),
                  title: Text(element.name!,style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors),),
                  subtitle: Text(element.songCount.toString() + "首",style: TextStyle(color:  Get.isDarkMode?dark_sub_text_Colors:light_sub_text_Colors)),
                  onTap: () async {
                    playListByMusicLogic.playlistID.value =element.id!;
                    playListByMusicLogic.is_deleted.value=true;
                    List<DataRow> data = await playListByMusicLogic.buildplayListView(
                        element.id!);
                    if (data.length == 0) {
                      serviceController.showWidget.value =
                          Container(child: Text("没有数据"));
                      return;
                    }
                    serviceController.showWidget.value =
                        Container(child: PlayListByMusicPage(data));
                    update(["right_widget"]);
                    serviceController.titleNmae.value = "收藏-${element.name}";
                  },
                  onLongPress: () {
                    _updateController.text = (element.name!);
                    var updated = true.obs;
                    showDialog(
                        context: Get.context!,
                        builder: (context) {
                          return AlertDialog(
                            title: RichText(text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "修改",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 20,

                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                        {
                                          updated.value = true
                                        }
                                  ),
                                  TextSpan(
                                    text: "/",
                                    style: TextStyle(
                                      color:Get.isDarkMode?dark_text_Colors:light_text_Colors,
                                      fontSize: 20,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "删除",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 20,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                        {
                                          updated.value = false
                                        }
                                  ),
                                ]
                            ),),
                            content: Obx(() {
                              if(updated.value){
                                return Row(
                                  children: [
                                    Container(width: 100, child: Text("新的歌单名称",style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors))),
                                    Container(
                                      width: 200,
                                      child: TextField(
                                        controller: _updateController,
                                      ),
                                    ),
                                  ],
                                );
                              }else{
                                return Container(
                                    width: 200,
                                    child: Text("确定删除该歌单?",style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)),
                                );
                              }
                            }),
                            actions: <Widget>[
                              GFButton(child: Text('取消',style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)), onPressed: () {
                                  Get.back();
                              },),
                              GFButton(child: Text('确认',style: TextStyle(color:  Get.isDarkMode?dark_text_Colors:light_text_Colors)), onPressed: () {
                                if(updated.value){
                                SubsonicApi.updatePlaylistRequest(element.id!,_updateController.text!).then((value) => {
                                  getPlayLists()
                                });
                                }else{
                                  SubsonicApi.deletePlaylistRequest(element.id!).then((value) => {
                                    getPlayLists()
                                  });
                                }
                                Get.back();
                              },),
                            ],
                          );
                        });
                  },
                ));
              });

              // SplayLists
            }
    } catch (e) {
      print(e);
    } finally {
      SplayLists_Widget.insert(SplayLists_Widget.length,
          IconButton(onPressed: () {
            var dialogTextField = DialogTextField(
                validator: (value) {
                  print('$value');
                  if (value!.isEmpty) {
                    return "歌单名称不能为空";
                  } else {
                    SubsonicApi.createPlaylistRequest(value).then((value) =>
                    {
                      getPlayLists()
                    });
                  }
                }

            );
            showTextInputDialog(title: "添加歌单",
                message: "请输入歌单名称",
                okLabel: "确定",
                cancelLabel: "取消",
                autoSubmit: true,
                style: AdaptiveStyle.material,
                useRootNavigator: true,
                // canPop: true,
                barrierDismissible: true,
                context: Get.context!,
                textFields: [dialogTextField]);
          }, icon: Icon(Icons.add, color: Get.isDarkMode?dark_text_Colors:light_text_Colors))
      );
      update(["play_list_view"]);

    }


  }
}
