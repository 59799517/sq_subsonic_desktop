import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/controller/entity/PlayMusicEntity.dart';
import 'package:sq_subsonic_desktop/page/left_widget/LeftController.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_album/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/widget/SqIconButton.dart';
import 'package:sq_subsonic_desktop/subsonic/models/MusicDirectoryByAlubmResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/MusicDirectoryResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/PlayListResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/PlugSearchResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/RandomSongsResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/SqSearchResult2.dart';
import 'package:sq_subsonic_desktop/utils/PlugApi.dart';
import 'package:sq_subsonic_desktop/utils/SubsonicApi.dart';

import '../../color/SqThemeData.dart';

class PlayListByMusicLogic extends GetxController {
  final serviceController = Get.put(ServiceController());

  final turn_page = false.obs;
  final is_deleted = false.obs;
  final playlistID = ''.obs;
  final is_plug_search = false.obs;
  final plug_search_value = "kw".obs;

  var playViewData = [];

  final Map keys = {};

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<DataRow>> buildStarListView() async {
    is_deleted.value = false;
    is_plug_search.value = false;

    var res = await SubsonicApi.starRequest();
    playViewData = res.subsonicResponse!.starred!.song!;
    return excute(res.subsonicResponse!.starred!.song!);
  }

  Future<List<DataRow>> getMusicListByAlubmId(String id) async {
    is_deleted.value = false;
    is_plug_search.value = false;

    MusicDirectoryResult res = await SubsonicApi.getMusicDirectoryRequest(id);
    playViewData = res.subsonicResponse!.directory!.child!;
    return excute(res.subsonicResponse!.directory!.child!);
  }

  Future<List<DataRow>> getMusicListByArtistId(String id) async {
    is_deleted.value = false;
    is_plug_search.value = false;

    MusicDirectoryByAlubmResult res =
        await SubsonicApi.getAlubmDirectoryRequest(id);
    var ids = [];

    ids = res.subsonicResponse!.directory!.child!.map((d) => d.id).toList();

    // res.subsonicResponse!.directory!.child!.forEach((element) {
    //   ids.add(element.id);
    // });
    var data = [];
    for (var id in ids) {
      var res = await SubsonicApi.getMusicDirectoryRequest(id);
      if (res.subsonicResponse!.directory!.child != null) {
        data.addAll(res.subsonicResponse!.directory!.child!);
      }
    }
    playViewData = data;
    return excute(data);
  }

  Future<List<DataRow>> search({int index = 1}) async {
    is_deleted.value = false;
    is_plug_search.value = false;

    SqSearchResult2 res = await SubsonicApi.search2Request(
        serviceController.searKey.value,
        pageNum: index);
    if (index == 1) {
      playViewData = res.subsonicResponse!.searchResult2!.song!;
    } else {
      playViewData.addAll(res.subsonicResponse!.searchResult2!.song!);
    }
    return excute(res.subsonicResponse!.searchResult2!.song!);
  }

  Future<List<DataRow>> searchplug({int index = 1, String type = "kw"}) async {
    plug_search_value.value = type;
    is_plug_search.value = true;
    PlugSearchResult res = await PlugApi.search(serviceController.searKey.value,
        type: type, pageNum: index);
    List<DataRow> playLists = [];

    if (serviceController.showSongImage.value) {
      res.data!.records!.forEach((element) {
        var dataRow = DataRow(cells: [
          DataCell(element.pic!.isEmpty
              ? GFAvatar(
                  child: Text(
                    element.name![0],
                    style: TextStyle(
                        color: Get.isDarkMode
                            ? dark_text_Colors
                            : light_text_Colors),
                  ),
                  shape: GFAvatarShape.standard)
              : Image.network(
                  element.pic!,
                  errorBuilder: (ctx, err, stackTrace) {
                    return GFAvatar(
                        child: Text(
                          element.name![0],
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? dark_text_Colors
                                  : light_text_Colors),
                        ),
                        shape: GFAvatarShape.standard);
                  },
                  width: 70,
                  height: 70,
                )),
          DataCell(Text(element.name!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Text(element.artistName!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Text(element.albumName!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Text('Auto',
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Row(
            children: [
              IconButton(
                icon: Icon(
                  LineIcons.play,
                  color: Get.isDarkMode ? dark_text_Colors : light_text_Colors,
                  size: 25,
                ),
                onPressed: () {
                  Map<String, dynamic> json = {
                    "id": element.id,
                    "parent": "",
                    "isDir": false,
                    "title": element.name,
                    "album": element.albumName,
                    "artist": element.artistName,
                    "track": 0,
                    "year": 0,
                    "genre": "",
                    "coverArt": element.pic,
                    "size": 0,
                    "contentType": "audio/mpeg",
                    "suffix": "Auto",
                    "duration": int.parse(element.duration.toString()),
                    "bitRate": 0,
                    "path": "",
                    "playCount": 0,
                    "played": "",
                    "discNumber": 0,
                    "created": "",
                    "albumId": "",
                    "artistId": "",
                    "type": "song",
                    "isVideo": false,
                    "lyric": "",
                    "sourType": plug_search_value.value
                  };
                  var playMusicEntity = PlayMusicEntity.fromJson(json);
                  serviceController.addPlayListWithIdPlayNow(
                      element.id!, playMusicEntity);
                },
              ),
              IconButton(
                  onPressed: () {
                    PlugApi.musicDownloadById(element.id!, type: type)
                        .then((value) => {
                              if (value)
                                {
                                  Get.snackbar("下载提示", "下载成功",
                                      duration: Duration(seconds: 1),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Get.isDarkMode
                                          ? dark_background_Colors
                                          : light_background_Colors,
                                      colorText: Get.isDarkMode
                                          ? dark_text_Colors
                                          : light_text_Colors)
                                }
                              else
                                {
                                  Get.snackbar("下载提示", "下载失败",
                                      duration: Duration(seconds: 1),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Get.isDarkMode
                                          ? dark_background_Colors
                                          : light_background_Colors)
                                }
                            });
                  },
                  icon: Icon(
                    LineIcons.plane,
                    color:
                        Get.isDarkMode ? dark_text_Colors : light_text_Colors,
                    size: 25,
                  ))
            ],
          ))
        ]);
        playLists.add(dataRow);
      });
    } else {
      res.data!.records!.forEach((element) {
        var dataRow = DataRow(cells: [
          DataCell(Text(element.name!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Text(element.artistName!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Text(element.albumName!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Text('Auto',
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(IconButton(
            icon: Icon(
              LineIcons.play,
              color: Get.isDarkMode ? dark_text_Colors : light_text_Colors,
              size: 25,
            ),
            onPressed: () {
              Map<String, dynamic> json = {
                "id": element.id,
                "parent": "",
                "isDir": false,
                "title": element.name,
                "album": element.albumName,
                "artist": element.artistName,
                "track": 0,
                "year": 0,
                "genre": "",
                "coverArt": element.pic,
                "size": 0,
                "contentType": "audio/mpeg",
                "suffix": "Auto",
                "duration": int.parse(element.duration.toString()),
                "bitRate": 0,
                "path": "",
                "playCount": 0,
                "played": "",
                "discNumber": 0,
                "created": "",
                "albumId": "",
                "artistId": "",
                "type": "song",
                "isVideo": false,
                "lyric": "",
                "sourType": plug_search_value.value
              };
              var playMusicEntity = PlayMusicEntity.fromJson(json);
              serviceController.addPlayListWithIdPlayNow(
                  element.id!, playMusicEntity);
            },
          ))
        ]);
        playLists.add(dataRow);
      });
    }

    return playLists;
  }

  Future<List<DataRow>> random() async {
    is_deleted.value = false;
    is_plug_search.value = false;

    RandomSongsResult res = await SubsonicApi.randomSongsRequest();
    playViewData = res.subsonicResponse!.randomSongs!.song!;

    return excute(res.subsonicResponse!.randomSongs!.song!);
  }

  Future<List<DataRow>> buildplayListView(String id) async {
    PlayListResult res = await SubsonicApi.playListRequest(id);
    if (res.subsonicResponse!.playlist!.entry != null) {
      playViewData = res.subsonicResponse!.playlist!.entry!;
      return excute(res.subsonicResponse!.playlist!.entry!);
    }
    playViewData = [];
    return [];
  }

  unStar(String id) {
    SubsonicApi.unStarAction(id);
  }

  star(String id) {
    SubsonicApi.starAction(id);
  }

  Future<List<Widget>> getAlbumListBYArtistId(String id) async {
    MusicDirectoryByAlubmResult res =
        await SubsonicApi.getAlubmDirectoryRequest(id);
    playViewData = res.subsonicResponse!.directory!.child!;
    return albumExcute(res.subsonicResponse!.directory!.child!);
  }

  Future<List<Widget>> albumExcute(data) async {
    List<Widget> playLists = [];
    var box = await Hive.openBox("play_list_star_album");
    if (serviceController.showAlbumImage.value) {
      for (var i = 0; i < data.length; i++) {
        var element = data[i];
        var imageurl =
            await SubsonicApi.getCoverArtRequestToImageUrl(element.id);
        playLists.add(GFListTile(
          title: Text(element.name,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors)),
          subTitle: Text('共有 ${element.songCount} 首',
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors)),
          avatar: imageurl.isEmpty
              ? GFAvatar(
                  child: Text(element.name[0],
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? dark_text_Colors
                              : light_text_Colors)),
                  shape: GFAvatarShape.standard)
              : Image.network(
                  imageurl,
                  errorBuilder: (ctx, err, stackTrace) {
                    return GFAvatar(
                        child: Text(element.name[0]),
                        shape: GFAvatarShape.standard);
                  },
                  width: 70,
                  height: 70,
                ),
          // );
          onTap: () {
            serviceController.titleNmae.value = "专辑：${element.name}";
            turn_page.value = false;

            getMusicListByAlubmId(element.id!).then((value) => {
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
                    turn_page.value = false;

                    getMusicListByAlubmId(element.id!).then((value) => {
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
      for (var i = 0; i < data.length; i++) {
        var element = data[i];
        playLists.add(GFListTile(
          title: Text(element.name,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors)),
          subTitle: Text('共有 ${element.songCount} 首',
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors)),
          // );
          onTap: () {
            serviceController.titleNmae.value = "专辑：${element.name}";
            turn_page.value = false;

            getMusicListByAlubmId(element.id!).then((value) => {
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
                    turn_page.value = false;

                    getMusicListByAlubmId(element.id!).then((value) => {
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
    }
    return playLists;
  }

  Future<List<DataRow>> excute(data) async {
    var box = await Hive.openBox("play_list_star_song");
    List<DataRow> playLists = [];

    List<Widget> service_Playlist = [];

    if (serviceController.showSongImage.value) {
      for (int i = 0; i < data.length; i++) {
        var element = data[i];
        var imageurl =
            await SubsonicApi.getCoverArtRequestToImageUrl(element.id);
        var dataRow = DataRow(cells: [
          DataCell(
            imageurl.isEmpty
                ? GFAvatar(
                    child: Text(
                      element.title[0],
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? dark_text_Colors
                              : light_text_Colors),
                    ),
                    shape: GFAvatarShape.standard)
                : CachedNetworkImage(
                    imageUrl: imageurl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Text(
                      element.title[0],
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? dark_text_Colors
                              : light_text_Colors),
                    ),
                  ),
          ),
          DataCell(Text(element.title!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(RichText(
            text: TextSpan(
                text: element.artist!,
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        serviceController.titleNmae.value =
                            "歌手：${element.artist!}",
                        turn_page.value = false,
                        getAlbumListBYArtistId(element.artistId!).then((value) {
                          serviceController.titleNmae.value =
                              "歌手：${element.artist!}";
                          serviceController.showWidget.value = Container(
                              child: PlayListByAlbumPage(
                                  value, PlayListByAlbumPageType.none));
                        })
                      }),
          )),
          DataCell(RichText(
            text: TextSpan(
                text: element.album!,
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        serviceController.titleNmae.value =
                            "专辑：${element.album!}",
                        turn_page.value = false,
                        getMusicListByAlubmId(element.albumId!).then((value) =>
                            {
                              serviceController.showWidget.value =
                                  Container(child: PlayListByMusicPage(value))
                            })
                      }),
          )),
          DataCell(Text(element.suffix.toString(),
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Row(
            children: [
              GetBuilder<LeftController>(builder: (logic) {
                return IconButton(
                  icon: is_deleted.value
                      ? Icon(
                          Icons.minimize,
                          color: Get.isDarkMode
                              ? dark_text_Colors
                              : light_text_Colors,
                          size: 25,
                        )
                      : Icon(
                          Icons.add,
                          color: Get.isDarkMode
                              ? dark_text_Colors
                              : light_text_Colors,
                          size: 25,
                        ),
                  onPressed: () async {
                    if (is_deleted.value) {
                      SubsonicApi.deletePlaylistSongRequest(playlistID.value, i)
                          .then((value) => {logic.getPlayLists()});
                    } else {
                      var data =
                          serviceController.server_playLists_info_list.value;
                      data.forEach((value) {
                        if (value != null) {
                          service_Playlist.add(GFListTile(
                            title: Text(
                              value.name,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? dark_text_Colors
                                      : light_text_Colors),
                            ),
                            onTap: () {
                              SubsonicApi.updatePlaylistSongRequest(
                                      value.id, element.id)
                                  .then((value) =>
                                      {Get.back(), logic.getPlayLists()});
                            },
                          ));
                        }
                      });
                      showDialog(
                          context: Get.context!,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("选择添加歌单",
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? dark_text_Colors
                                          : light_text_Colors)),
                              content: Container(
                                width: 200,
                                height: 200,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return service_Playlist[index];
                                  },
                                  itemCount: service_Playlist.length,
                                ),
                              ),
                            );
                          });
                    }
                  },
                );
              }),
              SqStarIconButton(
                  element.id!, box.get(element.id) != null ? true : false),
              IconButton(
                icon: Icon(
                  LineIcons.play,
                  color: Get.isDarkMode ? dark_text_Colors : light_text_Colors,
                  size: 25,
                ),
                onPressed: () {
                  var json = element.toJson();
                  var playMusicEntity = PlayMusicEntity.fromJson(json);
                  serviceController.addPlayListWithIdPlayNow(
                      element.id!, playMusicEntity);
                },
              ),
            ],
          ))
        ]);
        playLists.add(dataRow);
      }
    } else {
      for (int i = 0; i < data.length; i++) {
        var element = data[i];
        var dataRow = DataRow(cells: [
          DataCell(Text(element.title!,
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(RichText(
            text: TextSpan(
                text: element.artist!,
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        serviceController.titleNmae.value =
                            "歌手：${element.artist!}",
                        turn_page.value = false,
                        getAlbumListBYArtistId(element.artistId!).then((value) {
                          serviceController.titleNmae.value =
                              "歌手：${element.artist!}";
                          serviceController.showWidget.value = Container(
                              child: PlayListByAlbumPage(
                                  value, PlayListByAlbumPageType.none));
                        })
                      }),
          )),
          DataCell(RichText(
            text: TextSpan(
                text: element.album!,
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        serviceController.titleNmae.value =
                            "专辑：${element.album!}",
                        turn_page.value = false,
                        getMusicListByAlubmId(element.albumId!).then((value) =>
                            {
                              serviceController.showWidget.value =
                                  Container(child: PlayListByMusicPage(value))
                            })
                      }),
          )),
          DataCell(Text(element.suffix.toString(),
              style: TextStyle(
                  color:
                      Get.isDarkMode ? dark_text_Colors : light_text_Colors))),
          DataCell(Row(
            children: [
              GetBuilder<LeftController>(builder: (logic) {
                return IconButton(
                  icon: is_deleted.value
                      ? Icon(
                          Icons.minimize,
                          color: Get.isDarkMode
                              ? dark_text_Colors
                              : light_text_Colors,
                          size: 25,
                        )
                      : Icon(
                          Icons.add,
                          color: Get.isDarkMode
                              ? dark_text_Colors
                              : light_text_Colors,
                          size: 25,
                        ),
                  onPressed: () async {
                    if (is_deleted.value) {
                      SubsonicApi.deletePlaylistSongRequest(playlistID.value, i)
                          .then((value) => {logic.getPlayLists()});
                    } else {
                      var data =
                          serviceController.server_playLists_info_list.value;
                      data.forEach((value) {
                        if (value != null) {
                          service_Playlist.add(GFListTile(
                            titleText: value.name,
                            onTap: () {
                              SubsonicApi.updatePlaylistSongRequest(
                                      value.id, element.id)
                                  .then((value) =>
                                      {Get.back(), logic.getPlayLists()});
                            },
                          ));
                        }
                      });
                      showDialog(
                          context: Get.context!,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "选择添加歌单",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? dark_text_Colors
                                        : light_text_Colors),
                              ),
                              content: Container(
                                width: 200,
                                height: 200,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return service_Playlist[index];
                                  },
                                  itemCount: service_Playlist.length,
                                ),
                              ),
                            );
                          });
                    }
                  },
                );
              }),
              SqStarIconButton(
                  element.id!, box.get(element.id) != null ? true : false),
              IconButton(
                icon: Icon(
                  LineIcons.play,
                  color: Get.isDarkMode ? dark_text_Colors : light_text_Colors,
                  size: 25,
                ),
                onPressed: () {
                  var json = element.toJson();
                  var playMusicEntity = PlayMusicEntity.fromJson(json);
                  serviceController.addPlayListWithIdPlayNow(
                      element.id!, playMusicEntity);
                },
              ),
            ],
          )),
        ]);
        playLists.add(dataRow);
      }
    }

    return playLists;
  }
}
