import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_subsonic_desktop/color/SqThemeData.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/play_list_by_music/logic.dart';

class SqStarIconButton extends StatefulWidget {
  String id;
  bool star;
  Function callBack = () {};

  SqStarIconButton(this.id, this.star,{Function? callBack});


  @override
  State<SqStarIconButton> createState() => _SqStarIconButtonState();
}

class _SqStarIconButtonState extends State<SqStarIconButton> {
  final logic = Get.put(PlayListByMusicLogic());
  final serviceController = Get.put(ServiceController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.star_rate_outlined,
        color: widget.star ? Colors.redAccent : Get.isDarkMode?dark_text_Colors:light_text_Colors,
        size: 25,
      ),
      onPressed: () {
        if (widget.star) {
          setState(() {
            widget.star = false;
          });
          if (serviceController.musicID == widget.id) {
            serviceController.isStar.value = false;
          }
          logic.unStar(widget.id!);
        } else {
          setState(() {
            widget.star = true;
          });
          if (serviceController.musicID == widget.id) {
            serviceController.isStar.value = true;
          }
          logic.star(widget.id);
        }
          widget.callBack();
      },
    );
  }
}
