import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_subsonic_desktop/page/seting/logic.dart';

class HotKeyText extends StatefulWidget {

  late String hotkeyType ;
  late String docName ;
  late String scope ;

  HotKeyText( this.hotkeyType, this.docName,this.scope,);

  @override
  State<HotKeyText> createState() => _HotKeyTextState();
}

class _HotKeyTextState extends State<HotKeyText> {

  final logic = Get.put(SetingLogic());





  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      onTap: () {
        logic.openDialog(
            context,
            widget.hotkeyType,
            widget.docName,
            scope: widget.scope);
      },
      controller: TextEditingController(
          text: logic.getHotKeyValue(widget.docName,widget.scope).value

      ),
      readOnly: logic.readOnly.value,
      decoration: InputDecoration(
        enabledBorder:
        OutlineInputBorder(
            borderSide: BorderSide(
                color: logic
                    .readOnly
                    .value
                    ? Color(
                    0xffB6B6B6)
                    : Colors.red,
                width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: logic.readOnly
                    .value
                    ? Color(
                    0xffB6B6B6)
                    : Color(
                    0xffFD3F2A),
                width: logic.readOnly
                    .value
                    ? 0.5
                    : 1)),
        border: OutlineInputBorder(),
      ),
    );


  }
}
