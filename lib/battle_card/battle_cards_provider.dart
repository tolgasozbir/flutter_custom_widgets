import 'dart:math';

import 'package:flutter/material.dart';

enum CardStatus { Win , Lose }

class BattleCardProvider extends ChangeNotifier {
  CardStatus? cardStatus;
  bool topSelected = false;
  bool _isDragging = false;
  String topCardResult = "";
  String bottomCardResult = "";

  Offset _topCardPosition = Offset.zero;
  double _topCardAngle = 0;
  Offset _bottomCardPosition = Offset.zero;
  double _bottomCardAngle = 0;
  double _spacingHeight = 0;
  Size _screenSize = Size.zero;

  bool get isDragging => _isDragging;
  Offset get getTopCardPosition => _topCardPosition;
  double get getTopCardAngle => _topCardAngle;
  Offset get getBottomCardPosition => _bottomCardPosition;
  double get getBottomCardAngle => _bottomCardAngle;
  double get spacingHeight => _spacingHeight;

  void setScreenSize(Size size) => _screenSize = size;

  void startPosition(DragStartDetails details){
    _isDragging =true;
    notifyListeners();
  }
  void updatePosition(DragUpdateDetails details){
    _topCardPosition += Offset(-details.delta.dx, 0);
    _bottomCardPosition += Offset(details.delta.dx, 0);

    final topCardX = _topCardPosition.dx;
    _topCardAngle = 30 * topCardX / _screenSize.width;  
    final BottomCardX = _bottomCardPosition.dx;
    _bottomCardAngle = -30 * BottomCardX / _screenSize.width;

    _spacingHeight=32;
    notifyListeners();
  }
  void endPosition(){
    _isDragging = false;
    notifyListeners();

    CardStatus? bottomCardStatus = getBottomCardStatus(force: true);
    if (bottomCardStatus == CardStatus.Win) {
      WinPosition();
      reset(milliseconds: 1000);
    }else if(bottomCardStatus == CardStatus.Lose){
      losePosition();
      reset(milliseconds: 1000);
    }else{
      reset(milliseconds: 0);
    }
  }


  CardStatus? getBottomCardStatus({bool force=false}){

    final botX = _bottomCardPosition.dx;

    if (force) {
      final delta = 100;
      if (botX >= delta) {
        return CardStatus.Win;
      }else if(botX <= -delta){
        return CardStatus.Lose;
      }else {
        return null;
      }
    } else {
      final delta = 60;
      if (botX >= delta) {
        return CardStatus.Win;
      }else if(botX <= -delta){
        return CardStatus.Lose;
      }else {
        return null;
      }
    }
  }

  double getOpacity(){
    final delta = 120;
    final pos = max(_bottomCardPosition.dx.abs(), _bottomCardPosition.dy.abs());
    final opacity = pos / delta;
    return min(opacity, 1);
  }

  void WinPosition(){
    _topCardAngle = 90;
    _topCardPosition += Offset((-.2 * _screenSize.width), (0.7 * _screenSize.height));

    _bottomCardAngle = 270;
    _bottomCardPosition += Offset((-.2 * _screenSize.width), (0.7 * _screenSize.height));
    notifyListeners();
  }  
  void losePosition(){
    _topCardAngle = 270;
    _topCardPosition += Offset((-.2 * _screenSize.width), (0.7 * _screenSize.height));

    _bottomCardAngle = 90;
    _bottomCardPosition += Offset((-.2 * _screenSize.width), (0.7 * _screenSize.height));
    notifyListeners();
  }

  void reset({int milliseconds=1000}) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    _isDragging = false;
    _topCardPosition = Offset.zero;
    _bottomCardPosition = Offset.zero;
    _topCardAngle = 0;
    _bottomCardAngle = 0;
    _spacingHeight=0;
    notifyListeners();

  }  

}