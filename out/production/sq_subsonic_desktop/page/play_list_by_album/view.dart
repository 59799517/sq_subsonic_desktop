import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'logic.dart';


enum PlayListByAlbumPageType {
  search,
  albumsList,
  none
}

class PlayListByAlbumPage extends StatefulWidget {
  List<Widget> Lists = [];
  PlayListByAlbumPageType type ;


  PlayListByAlbumPage(this.Lists, this.type ,{Key? key});

  @override
  State<PlayListByAlbumPage> createState() => _PlayListByAlbumPageState();
}

class _PlayListByAlbumPageState extends State<PlayListByAlbumPage> {
  final logic = Get.put(PlayListByAlbumLogic());
  int index= 0;



  loadView() async{
    index++;
    var playlist  ;
    if(widget.type==PlayListByAlbumPageType.albumsList){
      playlist = await logic.buildAlbumsListView(index: index);
    }else if(widget.type==PlayListByAlbumPageType.search){
      playlist = await logic.search(index: index);
    }
    setState(() {
      widget.Lists.addAll(playlist);
    });
  }



  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
        onEndOfPage: () => {
          if(logic.turn_page.value){
            loadView()
          }
        },
        child: ListView.builder(
            itemBuilder: (context, index) =>widget.Lists[index],
            itemCount: widget.Lists.length)
    );
  }


}
