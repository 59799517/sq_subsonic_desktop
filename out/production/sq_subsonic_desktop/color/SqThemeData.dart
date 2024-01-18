
//创建Dark ThemeData对象
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ThemeData appDarkThemeData = ThemeData(
    backgroundColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColor: Colors.red, // 主要部分背景颜色（导航和tabBar等）
    scaffoldBackgroundColor:
    Colors.red, //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
    textTheme: TextTheme(displayLarge: TextStyle(color: Colors.yellow, fontSize: 15)),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.yellow)));

//创建light ThemeData对象
final ThemeData appLightThemeData = ThemeData(
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
          backgroundColor: Colors.blue
      )
    ),
    backgroundColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: Colors.blue, // 主要部分背景颜色（导航和tabBar等）
    scaffoldBackgroundColor:
    Colors.blue, //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
    textTheme: TextTheme(displayLarge: TextStyle(color: Colors.blue, fontSize: 15)),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)));

// class GetXThemes extends StatelessWidget {
//   const GetXThemes({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("主题"),
//       ),
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             //直接设置Theme
//             Get.changeTheme(
//                 Get.isDarkMode ? appLightThemeData : appDarkThemeData);
//             //设置ThemeMode
//             // Get.changeThemeMode(ThemeMode.dark);
//           },
//           child: Text(
//             "更换主题",
//             style: Get.textTheme.displayLarge,//这里有个问题,就是主题切换,这里的Text并不会更新
//           ),
//         ),
//       ),
//     );
//   }
// }
