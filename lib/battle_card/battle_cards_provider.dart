import 'dart:math';

import 'package:flutter/material.dart';

enum CardStatus{ Win, Lose }

class BattleCardProvider extends ChangeNotifier {
  bool _isDragging = false;
  String topCardResult = "";
  String bottomCardResult = "";
  bool _isTopCardDragging = false;

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

  void setDragging(bool isTopCardDragging){
    _isTopCardDragging = isTopCardDragging;
  }

  void startPosition(DragStartDetails details){
    _isDragging =true;
    notifyListeners();
  }
  void updatePosition(DragUpdateDetails details){
    if (_isTopCardDragging) {
      _topCardPosition += Offset(details.delta.dx, 0);
      _bottomCardPosition += Offset(-details.delta.dx, 0);
    }else {
      _topCardPosition += Offset(-details.delta.dx, 0);
      _bottomCardPosition += Offset(details.delta.dx, 0);
    }

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

    CardStatus? cardStatus = getTopCardStatus(force: true);
    if (cardStatus == CardStatus.Win) {
      like();
      reset1Sec();
    }else if(cardStatus == CardStatus.Lose){
      no();
      reset1Sec();
    }else{
      reset();
    }


  }

  CardStatus? getTopCardStatus ({bool force = false}){
    final topX = _topCardPosition.dx;
    //final botX = _bottomCardPosition.dx;

    if (force) {
      final delta = 100;
      if (topX >= delta) {
        return CardStatus.Win;
      }else if(topX <= -delta){
        return CardStatus.Lose;
      }else {
        return null;
      }  
    } else {
      final delta = 60;
    
      if (topX >= delta) {
        return CardStatus.Win;
      }else if(topX <= -delta){
        return CardStatus.Lose;
      }else {
        return null;
      }  
    }
  }

  double getOpacity(){
    final delta = 120;
    final pos = max(_topCardPosition.dx.abs(), _topCardPosition.dy.abs());
    final opacity = pos / delta;
    return min(opacity, 1);
  }

  void like(){
    _topCardAngle = 90;
    _bottomCardAngle = 90;
    _topCardPosition += Offset((-0.5 * _screenSize.width), (1 * _screenSize.height));
    _bottomCardPosition += Offset((0.5 * _screenSize.width), (1 * _screenSize.height));//Offset((-0.5 * _screenSize.width), (1 * _screenSize.height));
    notifyListeners();
  }  
  void no(){
    _topCardAngle = 270;
    _bottomCardAngle = 270;
    _topCardPosition += Offset((0.5 * _screenSize.width), (1 * _screenSize.height));
    _bottomCardPosition += Offset((0.5 * _screenSize.width), (1 * _screenSize.height));
    notifyListeners();
  }

  void reset() async {
    await Future.delayed(Duration(seconds: 0));
    _isDragging = false;
    _topCardPosition = Offset.zero;
    _bottomCardPosition = Offset.zero;
    _topCardAngle = 0;
    _bottomCardAngle = 0;
    _spacingHeight=0;
    notifyListeners();

  }  
  void reset1Sec() async {
    await Future.delayed(Duration(seconds: 1));
    _isDragging = false;
    _topCardPosition = Offset.zero;
    _bottomCardPosition = Offset.zero;
    _topCardAngle = 0;
    _bottomCardAngle = 0;
    _spacingHeight=0;
    notifyListeners();

  }

}