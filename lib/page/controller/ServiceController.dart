import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sq_subsonic_desktop/page/controller/entity/LoopTypeType.dart';
import 'package:sq_subsonic_desktop/subsonic/models/LyricsResult.dart';
import 'package:sq_subsonic_desktop/utils/PlugApi.dart';
import 'package:sq_subsonic_desktop/utils/SubsonicApi.dart';
import 'dart:convert' as json;

import 'entity/PlayMusicEntity.dart';

class ServiceController extends GetxController {
  //右侧显示的内容
  Rx<Widget> showWidget = Container().obs;

  //右侧标题
  RxString titleNmae = "Sq".obs;

//给钱名称
  var musicName = "".obs;

//图片url
  var musicImageUrl = "".obs;

//专辑
  var musicAlubm = "".obs;

//歌手
  var musicArtist = "".obs;

//总时长(毫秒)
  var musicDuration = 0.0.obs;

//id
  var musicID = "".obs;

//歌词
  var musicLyric = "".obs;

//是否标记星
  var isStar = false.obs; //
  //循环模式
  var loopType = LoopType.playList.obs;

  //播放工具
  var player = AudioPlayer();

  //播放列表
  late RxList playlist = [].obs;

  //播放下标
  late var currentPlayIndex = 0.obs;

  //设置自动播放标识
  late var openAutoPlay = false.obs;

  // 搜索关键字
  final searKey = "".obs;

  //显示图片
  var showAlbumImage = false.obs;
  var showArtistImage = false.obs;
  var showSongImage = false.obs;
  var themeName = "light".obs;

  //直接打开歌曲跳过专辑
  var openArtistToMusic = false.obs;
  var loginName = "".obs;

  var server_playLists_info_list = [].obs;

  //插件
  var plug_open = false.obs;

  //plug
  var plug_url = "".obs;
  var plug_username = "".obs;
  var plug_password = "".obs;

  //播放列表对应的参数信息
  late List currentSource;

  @override
  void onInit() {
    player = AudioPlayer();

    var tempDir = player.audioCache.getTempDir();
    print('tempDir: ${tempDir}');
    Hive.openBox('set_server_config').then((box) => {
          if (box.get("open_auto_play", defaultValue: "false") == "true")
            {
              //开启自动播放
              openAutoPlay.value = true
            }
          else
            {openAutoPlay.value = false},
          themeName.value = box.get("system_theme", defaultValue: "light"),
          loginName.value = box.get("service_username", defaultValue: "SQ"),
          plug_open.value =
              bool.parse(box.get("plug_open", defaultValue: "false")),
          plug_url.value =
              box.get("plug_url", defaultValue: "http://127.0.0.1:8080"),
          plug_username.value = box.get("plug_username", defaultValue: "admin"),
          plug_password.value = box.get("plug_password", defaultValue: "admin"),
          if (box.get("open_artist_to_music", defaultValue: "false") == "true")
            {openArtistToMusic.value = true}
          else
            {openArtistToMusic.value = false},
          if (box.get("show_album_image", defaultValue: "false") == "true")
            {showAlbumImage.value = true}
          else
            {showAlbumImage.value = false},
          if (box.get("show_artist_image", defaultValue: "false") == "true")
            {showArtistImage.value = true}
          else
            {showArtistImage.value = false},
          if (box.get("show_song_image", defaultValue: "false") == "true")
            {showSongImage.value = true}
          else
            {showSongImage.value = false},
          Hive.openBox("playlist_nowPlaying_seting").then((value) => {
                if (value.get("volume") == null)
                  {player.setVolume(1)}
                else
                  {player.setVolume(value.get("volume"))},
                if (value.get("playListType", defaultValue: "playList") ==
                    "playList")
                  {loopType.value = LoopType.playList}
                else if (value.get("playListType", defaultValue: "playList") ==
                    "single")
                  {loopType.value = LoopType.single}
                else if (value.get("playListType", defaultValue: "playList") ==
                    "random")
                  {loopType.value = LoopType.random}
                else if (value.get("playListType", defaultValue: "playList") ==
                    "none")
                  {loopType.value = LoopType.playList},
                update(["volume_view", "music_operation_view"])
              }),
          Hive.openBox("playlist_nowPlaying").then((box2) => {
                box2.toMap().forEach((key, e) {
                  Map<String, dynamic> map = {};
                  //将e中的key值转为字符串
                  e.forEach((key, value) {
                    map[key.toString()] = value;
                  });
                  PlayMusicEntity playMusicEntity =
                      PlayMusicEntity.fromJson(map);
                  playlist.add(playMusicEntity);
                }),
                Hive.openBox("playlist_nowPlaying_seting").then((box3) => {
                      currentPlayIndex.value =
                          box3.get("currentPlayIndex", defaultValue: 0),
                      if (playlist.length > 0)
                        {
                          if (playlist[currentPlayIndex.value] != null)
                            {
                              musicID.value =
                                  playlist[currentPlayIndex.value].id!,
                              musicLyric.value =
                                  playlist[currentPlayIndex.value].lyric==null||playlist[currentPlayIndex.value].lyric==""?"暂无歌词":playlist[currentPlayIndex.value].lyric,
                              musicName.value =
                                  playlist[currentPlayIndex.value].title!,
                              musicImageUrl.value =
                                  playlist[currentPlayIndex.value].coverArt!,
                              musicAlubm.value =
                                  playlist[currentPlayIndex.value].album!,
                              musicArtist.value =
                                  playlist[currentPlayIndex.value].artist!,
                              musicDuration.value =
                                  playlist[currentPlayIndex.value]
                                      .duration!
                                      .toDouble(),
                              update(["musicName_view", "musicImageUrl_view"]),
                              if (openAutoPlay.value)
                                {
                                  player.play(UrlSource(
                                      playlist[currentPlayIndex.value].url)),
                                }
                              else
                                {
                                  player
                                      .setSource(UrlSource(
                                          playlist[currentPlayIndex.value].url))
                                      .then((value) => {player.pause()})
                                }
                            }
                        }
                      else
                        {currentPlayIndex.value = 0}
                    })
              })
        });

    super.onInit();
  }

  addPlayListData(List data) async {
    playlist.value.clear();
    currentPlayIndex.value = 0;
    for (var element in data) {
      PlayMusicEntity da = PlayMusicEntity.fromJson(element.toJson());
      String url =
          await SubsonicApi.getPlayUrlRequest(da.id!, mediaType: da.suffix!);
      print('${url}');
      da.url = url;
      LyricsResult lyricsResult =
          await SubsonicApi.lyricsRRequest(da.title!, da.artist!);
      da.lyric = lyricsResult.subsonicResponse!.lyrics!.value==null||lyricsResult.subsonicResponse!.lyrics!.value==''?"":lyricsResult.subsonicResponse!.lyrics!.value;
      da.coverArt = await SubsonicApi.getCoverArtRequestToImageUrl(da.id!);
      int tempduration = da.duration!;
      tempduration = tempduration*1000;
      da.duration = tempduration;
      playlist.add(da);
    }
    PlayMusicEntity playMusicEntity = playlist.value[0];
    await player.play(UrlSource(playMusicEntity.url!));
    musicID.value = playMusicEntity.id!;
    musicLyric.value = playMusicEntity.lyric!;
    musicName.value = playMusicEntity.title!;
    musicImageUrl.value =
        await SubsonicApi.getCoverArtRequestToImageUrl(playMusicEntity.id!);
    musicAlubm.value = playMusicEntity.album!;
    musicArtist.value = playMusicEntity.artist!;
    musicDuration.value = playMusicEntity.duration!.toDouble();
    update(["musicName_view", "musicImageUrl_view", "play_page_musicinfo"]);
  }

  addPlayListWithId(String id, PlayMusicEntity playMusicEntity) async {
    String url = await SubsonicApi.getPlayUrlRequest(id,
        mediaType: playMusicEntity.suffix!);
    print('${url}');
    playMusicEntity.url = url;
    LyricsResult lyricsResult = await SubsonicApi.lyricsRRequest(
        playMusicEntity.title!, playMusicEntity.artist!);
    playMusicEntity.lyric = lyricsResult.subsonicResponse!.lyrics!.value;
    playMusicEntity.coverArt =
        await SubsonicApi.getCoverArtRequestToImageUrl(id);
    playlist.add(playMusicEntity);
  }

  addPlayListWithIdPlayNow(String id, PlayMusicEntity playMusicEntity) async {
    if (playMusicEntity.sourType != null || playMusicEntity.sourType == "") {
      if (playMusicEntity.sourType == "") {
        playMusicEntity.sourType = "kw";
      }
      var source =
          await PlugApi.getMusicPlayUrl(id, type: playMusicEntity.sourType!);
      playMusicEntity.url = source;
      var getsongInfoById =
          await PlugApi.getsongInfoById(id, type: playMusicEntity.sourType!);
      playMusicEntity.lyric = getsongInfoById["musicLyric"]==null||getsongInfoById["musicLyric"]==""?"暂无歌词！":getsongInfoById["musicLyric"];
      var box = await Hive.openBox("playlist_nowPlaying");
      box.put(id, playMusicEntity.toJson());
      if (playlist.length == 0) {
        playlist.add(playMusicEntity);
        currentPlayIndex.value = 0;
      } else {
        playlist.insert(currentPlayIndex.value + 1, playMusicEntity);
        currentPlayIndex.value = currentPlayIndex.value + 1;
      }
      updatePlayListSet();
      await player.play(UrlSource(source));
      musicID.value = playMusicEntity.id!;
      try {
        musicLyric.value = playMusicEntity.lyric!;
      } catch (e) {
        musicLyric.value ="暂无歌词";
      }
      musicName.value = playMusicEntity.title!;
      musicImageUrl.value = playMusicEntity.coverArt!;
      musicAlubm.value = playMusicEntity.album!;
      musicArtist.value = playMusicEntity.artist!;
      musicDuration.value = playMusicEntity.duration!.toDouble();
      update(["musicName_view", "musicImageUrl_view", "play_page_musicinfo"]);
    } else {
      Hive.openBox("play_list_star_song").then((box) => {
            if (box.get(id) != null)
              {isStar.value = true}
            else
              {isStar.value = false}
          });
      String url = await SubsonicApi.getPlayUrlRequest(id,
          mediaType: playMusicEntity.suffix!);
      print('${url}');
      playMusicEntity.url = url;
      LyricsResult lyricsResult = await SubsonicApi.lyricsRRequest(
          playMusicEntity.title!, playMusicEntity.artist!);
      playMusicEntity.lyric = lyricsResult.subsonicResponse!.lyrics!.value;
      playMusicEntity.coverArt =
          await SubsonicApi.getCoverArtRequestToImageUrl(id);

      var box = await Hive.openBox("playlist_nowPlaying");
      box.put(id, playMusicEntity.toJson());

      if (playlist.length == 0) {
        playlist.add(playMusicEntity);
        currentPlayIndex.value = 0;
      } else {
        playlist.insert(currentPlayIndex.value + 1, playMusicEntity);
        currentPlayIndex.value = currentPlayIndex.value + 1;
      }
      updatePlayListSet();
      await player.play(UrlSource(url));
      musicID.value = playMusicEntity.id!;
      musicLyric.value = (playMusicEntity.lyric==null||playMusicEntity.lyric==''?"暂无歌词":playMusicEntity.lyric)!;
      musicName.value = playMusicEntity.title!;
      musicImageUrl.value = await SubsonicApi.getCoverArtRequestToImageUrl(id);
      musicAlubm.value = playMusicEntity.album!;
      musicArtist.value = playMusicEntity.artist!;
      musicDuration.value = playMusicEntity.duration!.toDouble();
      update(["musicName_view", "musicImageUrl_view", "play_page_musicinfo"]);
    }
  }

  jumpMusic(int playListIndex) async {
    PlayMusicEntity music = playlist[playListIndex];

    Hive.openBox("play_list_star_song").then((box) => {
          if (box.get(music.id) != null) {isStar.value = true}
        });
    currentPlayIndex.value = playListIndex;
    updatePlayListSet();
    await player.play(UrlSource(music.url!));
    musicID.value = music.id!;
    musicLyric.value = (music.lyric==null||music.lyric==''?"暂无歌词":music.lyric)!;
    musicName.value = music.title!;
    musicImageUrl.value = music.coverArt!;
    musicAlubm.value = music.album!;
    musicArtist.value = music.artist!;
    musicDuration.value = music.duration!.toDouble();
    update(["musicName_view", "musicImageUrl_view", "play_page_musicinfo"]);
  }

  seek(int value) {
    player.seek(Duration(milliseconds: value.toInt()));
  }

  seekDuration(Duration duration) {
    player.seek(duration);
  }

  clearPlaylist() {
    playlist.clear();
    currentPlayIndex.value = 0;
    Hive.openBox("playlist_nowPlaying").then((value) => {value.clear()});
  }

  removePlayListAt(int index) {
    playlist.removeAt(index);
    if (index == currentPlayIndex.value) {
      currentPlayIndex.value = 0;
    } else if (index < currentPlayIndex.value) {
      currentPlayIndex.value--;
    }
    update(["playlist_view"]);
    updatePlayListSet();
  }

  resume() {
    player.resume();
    update([
      "musicName_view",
      "musicImageUrl_view",
      "lyric_view",
      "play_slider_view",
      "play_page_musicinfo"
    ]);
  }

  pause() {
    player.pause();
    update([
      "musicName_view",
      "musicImageUrl_view",
      "lyric_view",
      "play_slider_view",
      "play_page_musicinfo"
    ]);
  }

  setvolume(double value) {
    player.setVolume(value);
    update(["volume_view"]);
    updatevolume();
  }

  getvolume() {
    return player.volume;

  }

  nextSilent() {
    if (playlist.length == 0) {
      return;
    }

    if (currentPlayIndex.value < playlist.length - 1) {
      currentPlayIndex++;
      PlayMusicEntity nowMusic = playlist[currentPlayIndex.value];
      String url = nowMusic.url!;
      player.play(UrlSource(url));
      musicID.value = nowMusic.id!;
      musicLyric.value = (nowMusic.lyric==null||nowMusic.lyric==''?"暂无歌词":nowMusic.lyric)!;
      musicName.value = nowMusic.title!;
      musicImageUrl.value = nowMusic.coverArt!;
      musicAlubm.value = nowMusic.album!;
      musicArtist.value = nowMusic.artist!;
      musicDuration.value = nowMusic.duration!.toDouble();

      Hive.openBox("play_list_star_song").then((box) => {
            if (box.get(nowMusic.id!) != null)
              {isStar.value = true}
            else
              {isStar.value = false}
          });
      updatePlayListSet();
    } else if (currentPlayIndex.value == playlist.length - 1) {
      if (loopType.value == LoopType.playList) {
        currentPlayIndex.value = 0;
        PlayMusicEntity nowMusic = playlist[currentPlayIndex.value];
        String url = nowMusic.url!;
        player.play(UrlSource(url));
        musicID.value = nowMusic.id!;
        musicLyric.value = (nowMusic.lyric==null||nowMusic.lyric==''?"暂无歌词":nowMusic.lyric)!;
        musicName.value = nowMusic.title!;
        musicImageUrl.value = nowMusic.coverArt!;
        musicAlubm.value = nowMusic.album!;
        musicArtist.value = nowMusic.artist!;
        musicDuration.value = nowMusic.duration!.toDouble();

        Hive.openBox("play_list_star_song").then((box) => {
              if (box.get(nowMusic.id!) != null)
                {isStar.value = true}
              else
                {isStar.value = false}
            });
        updatePlayListSet();
      } else if (loopType.value == LoopType.random) {
        currentPlayIndex.value = 0;
        playlist.shuffle();
        PlayMusicEntity nowMusic = playlist.value[currentPlayIndex.value];
        String url = nowMusic.url!;
        player.play(UrlSource(url));
        musicID.value = nowMusic.id!;
        musicLyric.value = (nowMusic.lyric==null||nowMusic.lyric==''?"暂无歌词":nowMusic.lyric)!;
        musicName.value = nowMusic.title!;
        musicImageUrl.value = nowMusic.coverArt!;
        musicAlubm.value = nowMusic.album!;
        musicArtist.value = nowMusic.artist!;
        musicDuration.value = nowMusic.duration!.toDouble();

        Hive.openBox("play_list_star_song").then((box) => {
              if (box.get(nowMusic.id!) != null)
                {isStar.value = true}
              else
                {isStar.value = false}
            });
        updatePlayListSet();
      }
      update([
        "musicName_view",
        "musicImageUrl_view",
        "lyric_view",
        "play_slider_view",
        "play_page_musicinfo"
      ]);
    }
  }

  previousSilent() {
    if (currentPlayIndex.value == 0) {
      return;
    }
    if (currentPlayIndex.value > 0) {
      currentPlayIndex--;
      PlayMusicEntity nowMusic = playlist[currentPlayIndex.value];
      String url = nowMusic.url!;
      player.play(UrlSource(url));
      musicID.value = nowMusic.id!;
      musicLyric.value = (nowMusic.lyric==null||nowMusic.lyric==''?"暂无歌词":nowMusic.lyric)!;
      musicName.value = nowMusic.title!;
      musicImageUrl.value = nowMusic.coverArt!;
      musicAlubm.value = nowMusic.album!;
      musicArtist.value = nowMusic.artist!;
      musicDuration.value = nowMusic.duration!.toDouble();
      Hive.openBox("play_list_star_song").then((box) => {
            if (box.get(nowMusic.id!) != null)
              {isStar.value = true}
            else
              {isStar.value = false}
          });
      updatePlayListSet();
      update([
        "musicName_view",
        "musicImageUrl_view",
        "lyric_view",
        "play_slider_view",
        "play_page_musicinfo"
      ]);
    }
  }

  next(BuildContext context) async {
    if (playlist.length == 0) {
      showToast(
        "无下一曲",
        context: context,
        position: StyledToastPosition.center,
      );
    }
    if (currentPlayIndex.value < playlist.length - 1) {
      currentPlayIndex++;
      PlayMusicEntity nowMusic = playlist[currentPlayIndex.value];
      String url = nowMusic.url!;
      player.play(UrlSource(url));
      musicID.value = nowMusic.id!;
      musicLyric.value = (nowMusic.lyric==null||nowMusic.lyric==''?"暂无歌词":nowMusic.lyric)!;
      musicName.value = nowMusic.title!;
      musicImageUrl.value = nowMusic.coverArt!;
      musicAlubm.value = nowMusic.album!;
      musicArtist.value = nowMusic.artist!;
      musicDuration.value = nowMusic.duration!.toDouble();

      Hive.openBox("play_list_star_song").then((box) => {
            if (box.get(nowMusic.id!) != null)
              {isStar.value = true}
            else
              {isStar.value = false}
          });
      updatePlayListSet();
    } else {
      if (loopType.value == LoopType.random ||
          loopType.value == LoopType.playList ||
          loopType.value == LoopType.single) {
        currentPlayIndex.value = 0;
        if (loopType.value == LoopType.random) {
          playlist.shuffle();
        }
        PlayMusicEntity nowMusic = playlist[currentPlayIndex.value];
        String url = nowMusic.url!;
        player.play(UrlSource(url));
        musicID.value = nowMusic.id!;
        musicLyric.value = (nowMusic.lyric==null||nowMusic.lyric==''?"暂无歌词":nowMusic.lyric)!;
        musicName.value = nowMusic.title!;
        musicImageUrl.value = nowMusic.coverArt!;
        musicAlubm.value = nowMusic.album!;
        musicArtist.value = nowMusic.artist!;
        musicDuration.value = nowMusic.duration!.toDouble();

        Hive.openBox("play_list_star_song").then((box) => {
              if (box.get(nowMusic.id!) != null)
                {isStar.value = true}
              else
                {isStar.value = false}
            });
        updatePlayListSet();
      } else {
        showToast(
          "无下一曲",
          context: context,
          position: StyledToastPosition.center,
        );
      }
    }
    update([
      "musicName_view",
      "musicImageUrl_view",
      "lyric_view",
      "play_slider_view",
      "play_page_musicinfo"
    ]);
  }

  previous(BuildContext context) async {
    if (currentPlayIndex.value == 0) {
      showToast(
        "无上一曲",
        context: context,
        position: StyledToastPosition.center,
      );
    }
    if (currentPlayIndex.value > 0) {
      currentPlayIndex--;
      PlayMusicEntity nowMusic = playlist[currentPlayIndex.value];
      String url = nowMusic.url!;
      player.play(UrlSource(url));
      musicID.value = nowMusic.id!;
      musicLyric.value = (nowMusic.lyric==null||nowMusic.lyric==''?"暂无歌词":nowMusic.lyric)!;
      musicName.value = nowMusic.title!;
      musicImageUrl.value = nowMusic.coverArt!;
      musicAlubm.value = nowMusic.album!;
      musicArtist.value = nowMusic.artist!;
      musicDuration.value = nowMusic.duration!.toDouble();
      Hive.openBox("play_list_star_song").then((box) => {
            if (box.get(nowMusic.id!) != null)
              {isStar.value = true}
            else
              {isStar.value = false}
          });
      updatePlayListSet();
      update([
        "musicName_view",
        "musicImageUrl_view",
        "lyric_view",
        "play_slider_view",
        "play_page_musicinfo"
      ]);
    }
  }

  setPlayListType() {
    if (loopType.value == LoopType.single) {
      loopType.value = LoopType.playList;
    } else if (loopType.value == LoopType.playList) {
      loopType.value = LoopType.random;
      //下标标记为0
      currentPlayIndex.value = 0;
      //打乱列表
      playlist.shuffle();
      updatePlayListSet();
    } else if (loopType.value == LoopType.random) {
      loopType.value = LoopType.single;
    } else {
      loopType.value = LoopType.playList;
    }

    updatePlayListType();
    print('当前循环模式${loopType.value}');
    update(["music_operation_view"]);
  }

  updatePlayListSet() async {
    var box = await Hive.openBox("playlist_nowPlaying_seting");
    box.put("currentPlayIndex", currentPlayIndex.value);
  }

  updatevolume() async {
    var box = await Hive.openBox("playlist_nowPlaying_seting");
    box.put("volume", player.volume);
  }

  updatePlayListType() async {
    var box = await Hive.openBox("playlist_nowPlaying_seting");
    box.put("playListType", loopType.value.name.toString());
  }
}
