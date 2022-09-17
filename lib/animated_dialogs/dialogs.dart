import 'package:flutter/material.dart';

enum SlidePosition {
  left,right,top,bot,center
}

Future<T?> showAnimatedDialog<T extends Object?>({
  required BuildContext context,
  required Widget dialogPageContent,
  SlidePosition slidePosition = SlidePosition.center,
  Duration duration = const Duration(milliseconds: 600),
  bool barrierDismissible = true,
  Color barrierColor = const Color(0x80000000),
  //bool scaling = true,
  bool fading = true,
  bool scaleX = true,
  bool scaleY = true,
}) {
  Tween<Offset>? tween;
  switch (slidePosition) {
    case SlidePosition.left: tween = Tween(begin: Offset(-1,0),end: Offset(0,0)); break;
    case SlidePosition.right: tween = Tween(begin: Offset(1,0),end: Offset(0,0)); break;
    case SlidePosition.top: tween = Tween(begin: Offset(0,-1),end: Offset(0,0)); break;
    case SlidePosition.bot: tween = Tween(begin: Offset(0,1),end: Offset(0,0)); break;
    case SlidePosition.center: tween = Tween(begin: Offset(0,0),end: Offset(0,0)); break;
  }
  return showGeneralDialog(
    context: context,
    transitionDuration: duration,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: '',
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) { 
      return Material(
        type: MaterialType.transparency, 
        child: Align(
          alignment: Alignment.center, 
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 200, 
              maxWidth: MediaQuery.of(context).size.width*0.9,
              minHeight: 100,
              maxHeight: MediaQuery.of(context).size.height*0.9
            ),
            child: dialogPageContent
          )
        )
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,Widget child) {
      return SlideTransition(
        position: tween?.animate(animation) ?? Tween(begin: Offset(0,0),end: Offset(0,0)).animate(animation),
        child: Transform.scale(
          scaleX: scaleX ? animation.value : 1,
          scaleY: scaleY ? animation.value : 1,
          //scale: scaling ? animation.value : 1,
          child: Opacity(
            opacity: fading ? animation.value : 1,
            child: child
          ),
        ),
      );
    },
  );
}