import 'package:flutter/material.dart';
import 'package:sq_subsonic_desktop/page/widget/SqSearchBar.dart';

class RightTopBar extends StatefulWidget {

  String tilte = "标题";


  RightTopBar(this.tilte);

  @override
  State<RightTopBar> createState() => _RightTopBarState();
}

class _RightTopBarState extends State<RightTopBar> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return     Row(
      children: [
        Expanded(
            child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                              )),
                          Expanded(
                              flex: 40,
                              child: Container(
                                child: Text(widget.tilte),
                              )),
                          Expanded(
                            flex: 20,
                            child: Container(
                                child: SqSearchBar()),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ],
                ))),
      ],
    );


  }
}
