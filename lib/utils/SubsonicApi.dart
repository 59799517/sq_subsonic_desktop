import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:sq_subsonic_desktop/page/widget/CreatePlaylistResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/AlbumListResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/ArtistsResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/LyricsResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/MusicDirectoryByAlubmResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/MusicDirectoryResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/PlayListResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/PlayListsResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/RandomSongsResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/SqSearchResult2.dart';
import 'package:sq_subsonic_desktop/subsonic/models/SqSearchResult3.dart';
import 'package:sq_subsonic_desktop/subsonic/models/StarResult.dart';
import 'package:sq_subsonic_desktop/utils/DioManager.dart';
import 'package:uuid/uuid.dart';

class SubsonicApi {
  // 搜索
  static String search2 = "/rest/search2";
  static String ping = "/rest/ping.view";

  static String getPlaylists = "/rest/getPlaylists";
  static String getPlaylist = "/rest/getPlaylist";

  static String getCoverArt = "/rest/getCoverArt";

  static String getStarred = "/rest/getStarred";
  static String star = "/rest/star";
  static String unstar = "/rest/unstar";



  static String getMusicDirectory = "/rest/getMusicDirectory";

  static String stream = "/rest/stream";
  static String getLyrics = "/rest/getLyrics";

  static String getRandomSongs = "/rest/getRandomSongs";

  static String getArtists = "/rest/getArtists";


  static String getAlbumList = "/rest/getAlbumList";
  static String getUser = "/rest/getUser";


  static String createPlaylist = "/rest/createPlaylist";
  static String updatePlaylist = "/rest/updatePlaylist";
  static String deletePlaylist = "/rest/deletePlaylist";









  //id3搜索
  static String search3 = "/rest/search3";


  static getBaseUrl() async {
    var box = await Hive.openBox("server_info");
    return box.get("ip");
  }
  static getBaseUserName() async {
    var box = await Hive.openBox("server_info");
    return box.get("username");
  }
  static getBasePassword() async {
    var box = await Hive.openBox("server_info");
    return box.get("password");
  }
 static getBaseInfo() async {
    var box = await Hive.openBox("server_info");
    return box.get("info");
  }

  static getBaseRequestInfo() async {
    var box2 = await Hive.openBox("server_info_subsonic_api_info");
    return box2.toMap().cast<String, dynamic>();
  }

  static checkingServer(Map<String, dynamic> params ,String ip) async {
    try {
      Map<String, dynamic> result = await DioManager.get(url:ip+ping, params: params);
      return result;
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic> buildCheckiRequest(String username ,String password ){
    Map<String, dynamic> params = {};
    params["u"] = username;
    String  uuid = createRandomUUid();
    params["s"] = uuid;
    params["v"] = "1.13.0";
    params["c"] = "sq_subsonic_desktop";
    params["f"] = "json";
    params["t"] = md5.convert(utf8.encode(password+uuid)).toString();
    return params;
  }

  static Future<SqSearchResult2>   search2Request(String query,{int pageNum = 1,int pageSize = 20}) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map["query"] = query;
    map["artistCount"] = '$pageSize';
    map["albumCount"] = '$pageSize';
    map["songCount"] = '$pageSize';
    map["artistOffset"] = (pageNum-1)*pageSize<0?0:(pageNum-1)*pageSize;
    map["albumOffset"] = (pageNum-1)*pageSize<0?0:(pageNum-1)*pageSize;
    map["songOffset"] = (pageNum-1)*pageSize<0?0:(pageNum-1)*pageSize;
    Map<String, dynamic> result = await DioManager.get(url: url+search2, params: map);
    var searchResult2 = SqSearchResult2.fromJson(result);
    return searchResult2;
  }
  static Future<SqSearchResult3>   search3Request(String query,{int pageNum = 1,int pageSize = 20}) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map["query"] = query;
    Map<String, dynamic> result = await DioManager.get(url: url+search3, params: map);
    var sqSearchResult3 = SqSearchResult3.fromJson(result);
    return sqSearchResult3;
  }

  static Future<MusicDirectoryResult>  getMusicDirectoryRequest(String id) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['id']=id;
    Map<String, dynamic> result = await DioManager.get(url: url+getMusicDirectory, params: map);
    var musicDirectoryResultEntity = MusicDirectoryResult.fromJson(result);
    return musicDirectoryResultEntity;
  }


  static Future<MusicDirectoryByAlubmResult>  getAlubmDirectoryRequest(String id) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['id']=id;
    Map<String, dynamic> result = await DioManager.get(url: url+getMusicDirectory, params: map);
    var musicDirectoryResultEntity = MusicDirectoryByAlubmResult.fromJson(result);
    return musicDirectoryResultEntity;
  }


  static Future<PlayListsResult>  playListsRequest() async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    Map<String, dynamic> result = await DioManager.get(url: url+getPlaylists, params: map);
    var playListsResult = PlayListsResult.fromJson(result);
    return playListsResult;
  }

  static Future<PlayListResult>   playListRequest(String playListId) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['id']=playListId;
    Map<String, dynamic> result = await DioManager.get(url: url+getPlaylist, params: map);
    var playListResult = PlayListResult.fromJson(result);
    return playListResult;
  }
  static Future<StarResult> starRequest() async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    Map<String, dynamic> result = await DioManager.get(url: url+getStarred, params: map);
    var starResult = StarResult.fromJson(result);
    Map<String,dynamic> song = {};
    Map<String,dynamic> artist = {};
    Map<String,dynamic> album = {};
    for (var value in starResult.subsonicResponse!.starred!.song!) {
      song[value.id!] = value.toJson();
    }
    for (var value in starResult.subsonicResponse!.starred!.artist!) {
      artist[value.id!] = value.toJson();
    }
    for (var value in starResult.subsonicResponse!.starred!.album!) {
      album[value.id!] = value.toJson();
    }

    Hive.openBox("play_list_star_song").then((box) => {
      box.putAll(song)
    });
    Hive.openBox("play_list_star_artist").then((box) => {
      box.putAll(artist)
    });
    Hive.openBox("play_list_star_album").then((box) => {
      box.putAll(album)
    });
    return starResult;
  }
  static  Future<Uint8List> getCoverArtRequestTounit8list(String id,{int size=800}) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['id']=id;
    map['size']=size;
    var uint8list =  DioManager.getData(url: url+getCoverArt, params: map);
    return uint8list;
  }

  static  Future<String>  getCoverArtRequestToImageUrl(String id,{int size=800}) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    return url+getCoverArt+"?id=${id}&size=${size}&"+map.entries.map((e) => "${e.key}=${e.value}").join("&");
  }

  static  Future<String>  getPlayUrlRequest(String id) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    return url+stream+"?id=${id}&"+map.entries.map((e) => "${e.key}=${e.value}").join("&");
  }
  static Future<LyricsResult> lyricsRRequest(String title,String artist) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['title']=title;
    map['artist']=artist;
    Map<String, dynamic> result = await DioManager.get(url: url+getLyrics, params: map);
    var lyricsResult = LyricsResult.fromJson(result);
    return lyricsResult;
  }


  static   Future<RandomSongsResult> randomSongsRequest ({int size=50}) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['size']=size;
    Map<String, dynamic> result = await  DioManager.get(url: url+getRandomSongs, params: map);
    var randomSongsResult = RandomSongsResult.fromJson(result);
    return randomSongsResult;
  }

  static   Future<ArtistsResult> artistsRequest () async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    Map<String, dynamic> result = await  DioManager.get(url: url+getArtists, params: map);
    var artistsResult = ArtistsResult.fromJson(result);
    return artistsResult;
  }

  static Future<AlbumListResult> albumsRequest ({int pageNum = 1,int pageSize = 20}) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['size']=pageSize;
    map['offset']= (pageNum-1)*pageSize<0?0:(pageNum-1)*pageSize;
    map['type']="newest";
    Map<String, dynamic> result = await  DioManager.get(url: url+getAlbumList, params: map);
    var albumsResult = AlbumListResult.fromJson(result);
    return albumsResult;
  }

  static Future<bool> starAction (String id) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['id']=id;
    await  DioManager.get(url: url+star, params: map);
    return true;
  }

  static Future<bool> unStarAction (String id) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map['id']=id;
    await  DioManager.get(url: url+unstar, params: map);
    return true;
  }

  static Future< Map<String, dynamic>> getUserRequest () async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    Map<String, dynamic> result = await  DioManager.get(url: url+getUser, params: map);
    return result;
  }

  static Future< CreatePlaylistResult> createPlaylistRequest (String name) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map["name"]= name;
    Map<String, dynamic> result = await  DioManager.get(url: url+createPlaylist, params: map);
    CreatePlaylistResult createPlaylistResult = CreatePlaylistResult.fromJson(result);
    return createPlaylistResult;
  }

  static Future< bool> updatePlaylistRequest (String playlistId,String name) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map["name"]= name;
    map['playlistId'] = playlistId;
     await  DioManager.get(url: url+updatePlaylist, params: map);
    return true;
  }
  static Future< bool> deletePlaylistRequest (String playlistId) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map["id"]= playlistId;
    await  DioManager.get(url: url+deletePlaylist, params: map);
    return true;
  }
  static Future< bool> updatePlaylistSongRequest (String playlistId,String songID) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map["playlistId"]= playlistId;
    map['songIdToAdd'] = songID;
  var ccc =   await  DioManager.get(url: url+updatePlaylist, params: map);
    return true;
  }
  static Future< bool> deletePlaylistSongRequest (String playlistId,int songPlaylistIndex) async {
    String url = await getBaseUrl();
    Map<String, dynamic> map = await getBaseRequestInfo();
    map["playlistId"]= playlistId;
    map['songIndexToRemove'] = songPlaylistIndex;
    var ccc =  await  DioManager.get(url: url+updatePlaylist, params: map);
    return true;
  }


  static createRandomUUid(){
    //创建UUid
    return Uuid().v4().replaceAll("-", "");
  }


}
