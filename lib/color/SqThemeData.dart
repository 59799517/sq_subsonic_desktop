
//创建Dark ThemeData对象
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ColrosUtils.dart';

final ThemeData appDarkThemeData = ThemeData(
    fontFamily: 'alittf',
    buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.fromSwatch(
            // primarySwatch: Colors.blue,
            backgroundColor: dark_background_Colors
        )
    ),
    // dialogBackgroundColor: Colors.transparent,
    // backgroundColor: Colors.transparent,
    brightness: Brightness.dark,
    primaryColor: dark_background_Colors, // 主要部分背景颜色（导航和tabBar等）
    scaffoldBackgroundColor:
    dark_background_Colors, //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
    textTheme: TextTheme(displayLarge: TextStyle(color: ColrosUtils.fromHex("#FFD700"), fontSize: 15)),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: dark_background_Colors)),
    iconTheme: IconThemeData(
        color: dark_background_Colors
    ),
);

//创建light ThemeData对象
final ThemeData appLightThemeData = ThemeData(
    fontFamily: 'alittf',
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSwatch(
        // primarySwatch: Colors.blue,
          backgroundColor: light_background_Colors
      )
    ),
    // backgroundColor: Colors.transparent,
    // dialogBackgroundColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: light_background_Colors, // 主要部分背景颜色（导航和tabBar等）
    scaffoldBackgroundColor:
    light_background_Colors, //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
    textTheme: TextTheme(displayLarge: TextStyle(color: Colors.blue, fontSize: 15)),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: light_background_Colors)),
  iconTheme: IconThemeData(
      color: light_background_Colors
  ),
);

Color  dark_text_Colors = ColrosUtils.fromHex("#F596AA");
Color  light_text_Colors = Colors.black;

Color  dark_sub_text_Colors = ColrosUtils.fromHex("#FEDFE1");
Color  light_sub_text_Colors = Colors.black;

Color  dark_background_Colors = ColrosUtils.fromHex("#0B1013");
Color  light_background_Colors = ColrosUtils.fromHex("#f2f2f2");


// FFD700 金色


// 617172 夏天灰色
//7a7374 新灰色
// 132c33 深灰蓝


// #F596AA 桃粉
//#FEDFE1 樱花白





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
