import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sq_subsonic_desktop/color/SqThemeData.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_album/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_album/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/widget/SqIconButton.dart';
import 'package:sq_subsonic_desktop/subsonic/models/ArtistsResult.dart';
import 'package:sq_subsonic_desktop/subsonic/models/SqSearchResult2.dart';
import 'package:sq_subsonic_desktop/subsonic/models/StarResult.dart';
import 'package:sq_subsonic_desktop/utils/SubsonicApi.dart';
import 'package:sq_subsonic_desktop/subsonic/models/ArtistsResult.dart';

class PlayListByArtistLogic extends GetxController {

  final serviceController = Get.put(ServiceController());
  final playListByMusicLogic = Get.put(PlayListByMusicLogic());
  final playListByAlbumLogic = Get.put(PlayListByAlbumLogic());



  Future<List<Widget>> buildStarListView() async {
    var res = await SubsonicApi.starRequest();
    if (res.subsonicResponse?.starred?.artist != null) {
      return excute(res.subsonicResponse?.starred?.artist !);
    }
    return [];
  }
  Future<List<Widget>> buildArtistsListView() async {
    ArtistsResult res = await SubsonicApi.artistsRequest();
    if (res.subsonicResponse?.artists!.index!= null) {
      var data = [];
      res.subsonicResponse?.artists!.index!.forEach((element) {
        element.artist!.forEach((ccc) {
          data.add(ccc);
        });
      });
      return excute(data);
    }
    return [];
  }

  Future<List<Widget>>  search({int index= 1 }) async {
    SqSearchResult2 res =
    await SubsonicApi.search2Request(serviceController.searKey.value,pageNum: index);
    if (res.subsonicResponse?.searchResult2!.artist!= null) {
    return  excute(res.subsonicResponse?.searchResult2!.artist!);
    }
    return [];
  }

  Future<List<Widget>>  excute(data) async{
    var box = await Hive.openBox("play_list_star_artist");
    List<Widget> playLists = [];

    if(serviceController.showArtistImage.value){
      for (var element in data) {
        var imageurl = await  SubsonicApi.getCoverArtRequestToImageUrl(element.id);
        playLists.add(
            GFListTile(
              title:Text(element.name,style: TextStyle(color: Get.isDarkMode?dark_text_Colors:light_text_Colors)),
              subTitle:Text('共计${element.albumCount}张专辑',style: TextStyle(color: Get.isDarkMode?dark_sub_text_Colors:light_sub_text_Colors)) ,
              avatar: imageurl.isEmpty?GFAvatar(
                  child: Text(element.name[0],style: TextStyle(color: Get.isDarkMode?dark_text_Colors:light_text_Colors)),
                  shape: GFAvatarShape.standard
              ): Image.network(imageurl,errorBuilder: (ctx,err,stackTrace){
                return GFAvatar(
                    child: Text(element.name[0],style: TextStyle(color: Get.isDarkMode?dark_text_Colors:light_text_Colors),),
                    shape: GFAvatarShape.standard
                );
              },width: 70, height: 70,),
              icon: Row(
                children: [
                  SqStarIconButton(element.id!,box.get(element.id)!=null?true:false,callBack: (){

                  },),
                  IconButton(onPressed: (){

                    if(serviceController.openArtistToMusic.value){
                      // List<String> list = data.map((d)=>d.id).toList();

                      playListByMusicLogic.getMusicListByArtistId(element.id!).then((value) {
                        serviceController.titleNmae.value="歌手：${element.name!}";
                        serviceController.showWidget.value = Container(child: PlayListByMusicPage(value));
                      });
                    }else{
                      playListByAlbumLogic.getAlbumListBYArtistId(element.id!).then((value) {
                        serviceController.titleNmae.value="歌手：${element.name!}";
                        serviceController.showWidget.value = Container(child: PlayListByAlbumPage(value,PlayListByAlbumPageType.none));
                      });
                    }



                  }, icon: Icon(LineIcons.angleRight, color: Get.isDarkMode?dark_text_Colors:light_text_Colors,size: 25,))
                  ,
                ],
              ),
              onTap: (){
                if(serviceController.openArtistToMusic.value){
                  // List list = data.map((d)=>d.id).toList();
                  playListByMusicLogic.getMusicListByArtistId(element.id!).then((value) {
                    serviceController.titleNmae.value="歌手：${element.name!}";
                    serviceController.showWidget.value = Container(child: PlayListByMusicPage(value));
                  });
                }else{
                  playListByAlbumLogic.getAlbumListBYArtistId(element.id!).then((value) {
                    serviceController.titleNmae.value="歌手：${element.name!}";
                    serviceController.showWidget.value = Container(child: PlayListByAlbumPage(value,PlayListByAlbumPageType.none));
                  });
                }
              },
            )
        );
      }
    }else{
      for (var element in data) {
        playLists.add(
            GFListTile(
              title: Text(element.name!,style: TextStyle(color: Get.isDarkMode?dark_text_Colors:light_text_Colors)),
              subTitle: Text('共计${element.albumCount}张专辑',style: TextStyle(color: Get.isDarkMode?dark_sub_text_Colors:light_sub_text_Colors)),
              icon: Row(
                children: [
                  SqStarIconButton(element.id!,box.get(element.id)!=null?true:false,callBack: (){

                  },),
                  IconButton(onPressed: (){
                    if(serviceController.openArtistToMusic.value){
                      // List<String> list = data.map((d)=>d.id).toList();

                      playListByMusicLogic.getMusicListByArtistId(element.id!).then((value) {
                        serviceController.titleNmae.value="歌手：${element.name!}";
                        serviceController.showWidget.value = Container(child: PlayListByMusicPage(value));
                      });
                    }else{
                      playListByAlbumLogic.getAlbumListBYArtistId(element.id!).then((value) {
                        serviceController.titleNmae.value="歌手：${element.name!}";
                        serviceController.showWidget.value = Container(child: PlayListByAlbumPage(value,PlayListByAlbumPageType.none));
                      });
                    }
                  }, icon: Icon(LineIcons.angleRight, color: Get.isDarkMode?dark_text_Colors:light_text_Colors,size: 25,))
                  ,
                ],
              ),
              onTap: (){
                if(serviceController.openArtistToMusic.value){
                  // List<String> list = data.map((d)=>d.id).toList();

                  playListByMusicLogic.getMusicListByArtistId(element.id!).then((value) {
                    serviceController.titleNmae.value="歌手：${element.name!}";
                    serviceController.showWidget.value = Container(child: PlayListByMusicPage(value));
                  });
                }else{
                  playListByAlbumLogic.getAlbumListBYArtistId(element.id!).then((value) {
                    serviceController.titleNmae.value="歌手：${element.name!}";
                    serviceController.showWidget.value = Container(child: PlayListByAlbumPage(value,PlayListByAlbumPageType.none));
                  });
                }
              },
            )
        );
      }
    }



    return playLists;
  }




}
