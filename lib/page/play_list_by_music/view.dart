import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sq_subsonic_desktop/color/ColrosUtils.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';

import 'logic.dart';

class PlayListByMusicPage extends StatefulWidget {
  List<DataRow> lists = [];


  PlayListByMusicPage(this.lists);

  @override
  State<PlayListByMusicPage> createState() => _PlayListByMusicPageState();
}

class _PlayListByMusicPageState extends State<PlayListByMusicPage> {
  final musiclogic = Get.put(PlayListByMusicLogic());
  int index= 0;
  final serviceController = Get.put(ServiceController());

  loadView() async {
    index++;
    var playlist  =  await  musiclogic.search(index: index);
    setState(() {
      widget.lists.addAll(playlist);
    });
  }



  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
        onEndOfPage: () {
          if( musiclogic.turn_page.value){
            loadView();
          }
        },
        child: Padding(
      padding: const EdgeInsets.all(16),
      child:serviceController.showSongImage.value?DataTable2(
          columnSpacing: 12,
          showBottomBorder: false,
          isHorizontalScrollBarVisible: false,
          columns: [
            DataColumn2(
              label: Text('头像'),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text('名称'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('歌手'),
            ),
            DataColumn(
              label: Text('专辑'),
            ),
            DataColumn(
              label: Text('格式'),
            ),
            DataColumn(
              label: Row(
                children: [
                  Text("操作"),
                  GFButton(shape: GFButtonShape.pills,
                    // splashColor: Colors.blueAccent,
                    borderShape: const RoundedRectangleBorder(
                      //边框圆角
                      borderRadius: BorderRadius.all(
                        Radius.circular(80),
                      ),
                    ),
                    // type: GFButtonType.outline,
                    type: GFButtonType.outline,
                    // blockButton: true,
                    // highlightColor:Colors.orange,
                    color: Colors.transparent,
                    buttonBoxShadow: true,
                    hoverColor: ColrosUtils.fromHex("#dcdcdc"),
                    animationDuration: Duration(milliseconds: 3),
                    icon: Icon(Icons.play_arrow,color: Colors.redAccent,),
                    child: Text("播放全部",style: TextStyle(color: Colors.black,fontFamily: 'alittf'),),
                    hoverElevation: 0, onPressed: () {
                      serviceController.addPlayListData(musiclogic.playViewData);
                    },)
                ],
              ),
            ),

          ],
          rows: widget.lists):
      DataTable2(
          columnSpacing: 12,
          showBottomBorder: false,
          isHorizontalScrollBarVisible: false,
          columns: [
            // DataColumn2(
            //   label: Text('头像'),
            //   size: ColumnSize.L,
            // ),
            DataColumn2(
              label: Text('名称'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('歌手'),
            ),
            DataColumn(
              label: Text('专辑'),
            ),
            DataColumn(
              label: Text('格式'),
            ),
            DataColumn(
              label: Text('操作'),
            ),
          ],
          rows: widget.lists),
    ));
  }
}
