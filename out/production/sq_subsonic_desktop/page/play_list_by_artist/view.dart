import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PlayListByArtistPage extends StatefulWidget {
  List<Widget> Lists = [];


  PlayListByArtistPage(this.Lists, {Key? key});

  @override
  State<PlayListByArtistPage> createState() => _PlayListByArtistPageState();
}

class _PlayListByArtistPageState extends State<PlayListByArtistPage> {
  final logic = Get.put(PlayListByArtistLogic());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) =>widget.Lists[index],
        itemCount: widget.Lists.length)
    );
  }
}
