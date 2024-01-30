import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:sq_subsonic_desktop/page/controller/ServiceController.dart';
import 'package:sq_subsonic_desktop/page/seting/logic.dart';
import 'package:sq_subsonic_desktop/utils/PlugApi.dart';


class PlugConfigPage extends StatefulWidget {
  const PlugConfigPage({Key? key}) : super(key: key);

  @override
  State<PlugConfigPage> createState() => _PlugConfigPageState();
}

class _PlugConfigPageState extends State<PlugConfigPage> {
  final serviceController = Get.put(ServiceController());
  final setlogic = Get.put(SetingLogic());


  @override
  Widget build(BuildContext context) {
    var plugusernameController =
    TextEditingController(text: serviceController.plug_username.value);
    var plugpasswordController =
    TextEditingController(text: serviceController.plug_password.value);
    var plugurlController =
    TextEditingController(text: serviceController.plug_url.value);

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: GetBuilder<ServiceController>(
          id: "plug_view",
          builder: (logic) {
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,child: Text("开启插件：")),
                  Expanded(
                    flex: 1,
                    child: Switch(
                        activeColor: Colors.green,
                        splashRadius: 0,
                        inactiveThumbColor: Colors.black26,
                        value: serviceController.plug_open.value,
                        onChanged: (value) {
                          print('插件开关：$value');
                          serviceController.plug_open.value = value;
                          setlogic.setServeConfig("plug_open", value.toString());
                          serviceController.update(["plug_view"]);
                        }),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,child: Text("插件地址：")),
                  Expanded(
                    flex: 1,
                      child: Container(
                        width: 300,
                      height: 35,
                      child: TextField(
                      decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Colors.green,
                      width: 1),
                      ),
                      border: OutlineInputBorder(),
                      ),
                      controller: plugurlController,
                      ),
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,child: Text("插件用户名：")),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 300,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 1),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        controller: plugusernameController,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,child: Text("插件密码：")),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 300,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 1),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        controller: plugpasswordController,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GFButton(onPressed: (){
                    PlugApi.loginPlug( plugurlController.text,  plugusernameController.text,plugpasswordController.text).then((value) => {
                      if(value){
                        serviceController.update(["plug_view"]),
                        Get.snackbar("保存成功", "插件已开启", duration: Duration(seconds: 1))
                      }else{
                      serviceController.plug_open.value = false,
                      setlogic.setServeConfig("plug_open", "false"),
                      serviceController.update(["plug_view"]),
                        Get.snackbar("保存失败", "插件开启失败", duration: Duration(seconds: 1))
                      }
                    });
                    },child: Text("保存"),),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }


}
