import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'dart:convert' as convert;


class TestWidge extends StatefulWidget {
  @override
  State<TestWidge> createState() => _TestWidgeState();
}

class _TestWidgeState extends State<TestWidge> {
  var _hotKey =null;
  @override
  void initState() {
    super.initState();
    // Map<String, dynamic> json ={"keyCode": "arrowRight", "modifiers": "[alt]", "identifier": "54e97eea-c79d-40c4-9749-5b56c53469e0", "scope": "inapp"};
    // Map<String, dynamic>  jsonEncode = convert.jsonDecode("{\"keyCode\": \"arrowRight\", \"modifiers\": \"[alt]\", \"identifier\": \"54e97eea-c79d-40c4-9749-5b56c53469e0\", \"scope\": \"inapp\"}");

    // var list = List<String>.from(<String>['alt','shift', 'control','meta']);

    // var jsonDecode = convert.jsonDecode('{"keyCode":"arrowDown","modifiers":["control","alt"],"identifier":"92b6a4f6-85d7-49b1-9d71-95ba9311066b","scope":"system"}');
    // _hotKey =  HotKey.fromJson(jsonDecode);
    // hotKeyManager.register(
    //   _hotKey,
    //   keyDownHandler: (hotKey) {
    //     print('onKeyDown+${hotKey.toJson()}');
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
       child: Stack(
      alignment: Alignment.center,
      children: [
        // HotKeyVirtualView(hotKey: _hotKey)
        HotKeyRecorder(
          onHotKeyRecorded: (hotKey) {
            print('热键：${convert.jsonEncode(hotKey.toJson())}');
          },
        ),
      ],
    ),

      ),
    );
  }
}
