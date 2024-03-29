import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/color/SqThemeData.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/widget/SqIconButton.dart';
import 'package:sq_subsonic_desktop/subsonic/models/AlbumListResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/MusicDirectoryByAlubmResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/MusicDirectoryResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/SqSearchResult2.dart';
import 'package:sq_subsonic_desktop/utils/SubsonicApi.dart';

class PlayListByAlbumLogic extends GetxController {
  // final playListByMusicLogic = Get.put(PlayListByMusicLogic());
  final playListByMusicLogic = Get.put(PlayListByMusicLogic());
  final serviceController = Get.put(ServiceController());
  final turn_page = false.obs;
  final index = 0.obs;

  Future<List<Widget>> buildStarListView() async {
    var res = await SubsonicApi.starRequest();
    return excute(res.subsonicResponse?.starred?.album!);
  }

  Future<List<Widget>> getAlbumListBYArtistId(String id) async {
    MusicDirectoryByAlubmResult res =
        await SubsonicApi.getAlubmDirectoryRequest(id);
    return excute(res.subsonicResponse!.directory!.child!);
  }

  Future<List<Widget>> buildAlbumsListView({int index = 0}) async {
    AlbumListResult res = await SubsonicApi.albumsRequest(pageNum: index);
    return excute(res.subsonicResponse!.albumList!.album!);
  }

  Future<List<Widget>> search({int index = 0}) async {
    SqSearchResult2 res = await SubsonicApi.search2Request(
        serviceController.searKey.value,
        pageNum: index);
    return excute(res.subsonicResponse!.searchResult2!.album!);
  }

  Future<List<Widget>> excute(data) async {
    List<Widget> playLists = [];
    var box = await Hive.openBox("play_list_star_album");
    if (serviceController.showAlbumImage.value) {
      for (var i = 0; i < data.length; i++) {
        var element = data[i];
        var imageurl =
            await SubsonicApi.getCoverArtRequestToImageUrl(element.id);
        playLists.add(GFListTile(
          title: Text(
            element.name,
            style: TextStyle(
                color: Get.isDarkMode ? dark_text_Colors : light_text_Colors),
          ),
          subTitle: Text(
            '共有 ${element.songCount} 首',
            style: TextStyle(
                color: Get.isDarkMode
                    ? dark_sub_text_Colors
                    : light_sub_text_Colors),
          ),
          avatar: imageurl.isEmpty
              ? GFAvatar(
                  child: Text(element.name[0]), shape: GFAvatarShape.standard)
              : CachedNetworkImage(
                  imageUrl: imageurl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Text(element.name[0]),
                ),
          onTap: () {
            serviceController.titleNmae.value = "专辑：${element.name}";
            playListByMusicLogic.turn_page.value = false;
            playListByMusicLogic
                .getMusicListByAlubmId(element.id!)
                .then((value) => {
                      serviceController.showWidget.value =
                          Container(child: PlayListByMusicPage(value))
                    });
          },
          icon: Row(
            children: [
              SqStarIconButton(
                  element.id!, box.get(element.id) != null ? true : false),
              IconButton(
                  onPressed: () {
                    serviceController.titleNmae.value = "专辑：${element.name}";
                    playListByMusicLogic.turn_page.value = false;
                    playListByMusicLogic
                        .getMusicListByAlubmId(element.id!)
                        .then((value) => {
                              serviceController.showWidget.value =
                                  Container(child: PlayListByMusicPage(value))
                            });
                  },
                  icon: Icon(
                    LineIcons.angleRight,
                    color:
                        Get.isDarkMode ? dark_text_Colors : light_text_Colors,
                    size: 25,
                  )),
            ],
          ),
        ));
      }
    } else {
      data.forEach((element) {
        playLists.add(GFListTile(
          title: Text(
            element.name,
            style: TextStyle(
                color: Get.isDarkMode ? dark_text_Colors : light_text_Colors),
          ),
          subTitle: Text(
            '共有 ${element.songCount} 首',
            style: TextStyle(
                color: Get.isDarkMode
                    ? dark_sub_text_Colors
                    : light_sub_text_Colors),
          ),
          onTap: () {
            serviceController.titleNmae.value = "专辑：${element.name}";
            playListByMusicLogic.turn_page.value = false;
            playListByMusicLogic
                .getMusicListByAlubmId(element.id!)
                .then((value) => {
                      serviceController.showWidget.value =
                          Container(child: PlayListByMusicPage(value))
                    });
          },
          icon: Row(
            children: [
              SqStarIconButton(
                  element.id!, box.get(element.id) != null ? true : false),
              IconButton(
                  onPressed: () {
                    serviceController.titleNmae.value = "专辑：${element.name}";
                    playListByMusicLogic.turn_page.value = false;
                    playListByMusicLogic
                        .getMusicListByAlubmId(element.id!)
                        .then((value) => {
                              serviceController.showWidget.value =
                                  Container(child: PlayListByMusicPage(value))
                            });
                  },
                  icon: Icon(
                    LineIcons.angleRight,
                    color:
                        Get.isDarkMode ? dark_text_Colors : light_text_Colors,
                    size: 25,
                  )),
            ],
          ),
        ));
      });
    }
    return playLists;
  }
}
