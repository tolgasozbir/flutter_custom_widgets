import 'package:flutter/material.dart';

class BattleCardProvider extends ChangeNotifier {
  bool topSelected = false;
  bool _isDragging = false;
  String topCardResult = "";
  String bottomCardResult = "";
  bool _isTopCardDragging = false;
  bool _isBottomCardDragging = false;
  Offset _topCardPosition = Offset.zero;
  double _topCardAngle = 0;
  Offset _bottomCardPosition = Offset.zero;
  double _bottomCardAngle = 0;
  double _spacingHeight = 0;
  Size _screenSize = Size.zero;

  bool get isDragging => _isDragging;
  bool get isTopCardDragging => _isTopCardDragging;
  Offset get getTopCardPosition => _topCardPosition;
  double get getTopCardAngle => _topCardAngle;
  bool get isBottomCardDragging => _isBottomCardDragging;
  Offset get getBottomCardPosition => _bottomCardPosition;
  double get getBottomCardAngle => _bottomCardAngle;
  double get spacingHeight => _spacingHeight;

  void setScreenSize(Size size) => _screenSize = size;

  void setDragging(bool isTopCardDragging){
       _isTopCardDragging = isTopCardDragging;
       if (_isTopCardDragging) {
         _isBottomCardDragging = false;
         _isTopCardDragging=true;
         topSelected = true;
       }else if(!_isTopCardDragging){
        _isBottomCardDragging = true;
        _isTopCardDragging=false;
        topSelected = false;
       }
  }

  void startPosition(DragStartDetails details){
    _isDragging =true;
    if (topSelected) {
      _isBottomCardDragging = false;
      _isTopCardDragging = true;
    }else if(!topSelected){
      _isBottomCardDragging = true;
      _isTopCardDragging = false;
    }
    notifyListeners();
  }
  void updatePosition(DragUpdateDetails details){
    if (_isTopCardDragging) {
      _topCardPosition += Offset(details.delta.dx, 0);
      _bottomCardPosition += Offset(-details.delta.dx, 0);
      print("top true");
    }else if(!_isTopCardDragging){
      _topCardPosition += Offset(-details.delta.dx, 0);
      _bottomCardPosition += Offset(details.delta.dx, 0);
      print("bot true");
      print(_isTopCardDragging);
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
    _isBottomCardDragging = false;
    _isBottomCardDragging = false;
    notifyListeners();

    cardStatus();
    if (topCardResult == "Like") {
      like();
      reset1Sec();
    }else if(topCardResult == "No"){
      no();
      reset1Sec();
    }else{
      reset();
    }
    print(topCardResult);


  }

  void cardStatus (){
    final topX = _topCardPosition.dx;
    final botX = _bottomCardPosition.dx;

    final delta = 100;

    if (topX >= delta) {
      topCardResult ="No";
    }else if(topX <= -delta){
      topCardResult ="Like";
    }else {
      topCardResult ="";
    }    
    
    if (botX >= delta) {
      bottomCardResult ="No";
    }else if(botX <= -delta){
      bottomCardResult ="Like";
    }else {
      bottomCardResult ="";
    }

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
        _isBottomCardDragging = false;
    _isBottomCardDragging = false;
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
        _isBottomCardDragging = false;
    _isBottomCardDragging = false;
    _topCardPosition = Offset.zero;
    _bottomCardPosition = Offset.zero;
    _topCardAngle = 0;
    _bottomCardAngle = 0;
    _spacingHeight=0;
    notifyListeners();

  }

}