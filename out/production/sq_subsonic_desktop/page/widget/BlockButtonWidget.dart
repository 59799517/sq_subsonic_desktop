import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:sq_subsonic_desktop/color/ColrosUtils.dart';

class BlockButtonWidget extends GFButton {

    BlockButtonWidget( {
      super.key,
      required String name,
      required Icon super.icon,
      required VoidCallback onPressed,
    }) : super(
          onPressed: onPressed,
          // text: name,
          child: Text(name),
          shape: GFButtonShape.pills,
          splashColor: Colors.blueAccent,
          borderShape: const RoundedRectangleBorder(
            //边框圆角
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        // type: GFButtonType.outline,
        type: GFButtonType.outline,
        blockButton: true,
        // highlightColor:Colors.orange,
        color: Colors.transparent,
        buttonBoxShadow: true,
        hoverColor: ColrosUtils.fromHex("#dcdcdc"),
        animationDuration: Duration(milliseconds: 3),
        hoverElevation: 0,
);



}

