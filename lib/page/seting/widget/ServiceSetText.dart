import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/seting/logic.dart';

class ServiceSetText extends StatefulWidget {

  late String hotkeyType ;
  late String docName ;
  late String scope ;

  ServiceSetText( this.hotkeyType, this.docName,this.scope,);

  @override
  State<ServiceSetText> createState() => _ServiceSetTextState();
}

class _ServiceSetTextState extends State<ServiceSetText> {
  final logic = Get.put(SetingLogic());





  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  TextFormField(

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
                color:logic.readOnly
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
