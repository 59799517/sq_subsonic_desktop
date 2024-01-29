import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/left_widget/LeftController.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_album/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_album/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_artist/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_artist/view.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/logic.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/view.dart';

class SqSearchBar extends StatefulWidget {
  @override
  State<SqSearchBar> createState() => _SqSearchBarState();
}

class _SqSearchBarState extends State<SqSearchBar> {
  @override
  void initState() {
    super.initState();
  }
  final musiclogic = Get.put(PlayListByMusicLogic());
  final serviceController = Get.put(ServiceController());
  final albumLogic = Get.put(PlayListByAlbumLogic());
  final artistLogic = Get.put(PlayListByArtistLogic());
  LeftController leftController = Get.put(LeftController());


  @override
  Widget build(BuildContext context) {



    return TypeAheadField<ExampleItem>(
      // emptyBuilder: (context){
      //   // return Null();
      // } ,
      suggestionsCallback: (search) async{
        if(search==null||search==""){
          return [];
        }
        if(serviceController.plug_open.value){
          var box = await Hive.openBox("plug_type");
          var map = box.toMap();
          List<ExampleItem> addex = [];
          addex.add(ExampleItem(title: "$search", type: "单曲",plugvalue: ""));
          addex.add(ExampleItem(title: "$search", type: "歌手",plugvalue: ""));
          addex.add(ExampleItem(title: "$search", type: "专辑",plugvalue: ""));
          map.forEach((key, value) {
            addex.add(ExampleItem(title: "$search", type: "插件:${key}",plugvalue: value));
          });
          return addex;
        }else{
          return [
            ExampleItem(title: "$search", type: "单曲",plugvalue: ""),
            ExampleItem(title: "$search", type: "歌手",plugvalue: ""),
            ExampleItem(title: "$search", type: "专辑",plugvalue: "")
          ];
        }

      },
      builder: (context, controller, focusNode) {
        return Container(
          alignment: Alignment.center,
          height: 35,
          child: TextField(
              onSubmitted:(value)async{
                if(value!=null&&value!=""){
                  //单曲
                  serviceController.searKey.value = value;
                  musiclogic.turn_page.value = true;
                  var search = await musiclogic.search();
                  serviceController.showWidget.value = Container(child: PlayListByMusicPage(search));
                }
              },
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                border: OutlineInputBorder(
                  //圆角大小调制，不调为默认的大小
                  borderRadius: BorderRadius.all(
                      Radius.circular(100.0)),
                  // borderSide: BorderSide.none,
                ),
                prefixIcon:
                Icon(Icons.search_outlined),
                // suffixIcon: IconButton(
                //   icon: Icon(Icons.clear_outlined),
                //   onPressed: () {
                //     controller.clear();
                //   },
                // ),
              )),
        );
      },
      itemBuilder: (context, item) {
        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.type),
        );
      },
      onSelected:  (item) async{
        serviceController.titleNmae.value = "搜索${item.type}：${item.title}";
        if(item.type=="单曲"){
          //单曲
          serviceController.searKey.value = item.title;
          musiclogic.turn_page.value = true;
          var search = await musiclogic.search();
          serviceController.showWidget.value = Container(child: PlayListByMusicPage(search));
        }else if(item.type=="歌手"){
          //歌手
          serviceController.searKey.value = item.title;
          List<Widget> search = await artistLogic.search();
          serviceController.showWidget.value = Container(
            child: PlayListByArtistPage(search),
          );
          leftController.update(["right_widget"]);
        }else if(item.type=="专辑"){
          //专辑
          serviceController.searKey.value = item.title;
          albumLogic.turn_page.value = true;
          List<Widget> search = await albumLogic.search();
          serviceController.showWidget.value = Container(
            child: PlayListByAlbumPage(search,PlayListByAlbumPageType.search),
          );
          leftController.update(["right_widget"]);
        }else{
          if( item.type.contains("插件")||item.plugvalue!=''){
            serviceController.searKey.value = item.title;
            musiclogic.turn_page.value = true;
            var search = await musiclogic.searchplug(type: item.plugvalue);
            serviceController.showWidget.value = Container(child: PlayListByMusicPage(search));
          }

        }
        print(item.title);
        print(item.type);
      },
    );
  }
}
class ExampleItem {
  final String title;
  final String type;
  final String plugvalue;
  ExampleItem({
    required this.title,
    required this.type,
     required this.plugvalue,
  });
}
