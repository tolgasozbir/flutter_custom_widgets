import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [
    "https://picsum.photos/400/400?random=1"
    "https://picsum.photos/400/400?random=2"
    "https://picsum.photos/400/400?random=3"
    "https://picsum.photos/400/400?random=4"
    "https://picsum.photos/400/400?random=5"
    "https://picsum.photos/400/400?random=6"
    "https://picsum.photos/400/400?random=7"
    "https://picsum.photos/400/400?random=8"
  ];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  double _angle = 0;
  Size _screenSize = Size.zero;
  double _spacingHeight = 0;

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get getPosition => _position;
  double get angle => _angle;
  double get spacingHeight => _spacingHeight;

  void setScreenSize(Size size) => _screenSize = size;

  void startPosition(DragStartDetails details){
    _isDragging =true;
    notifyListeners();
  }
  void updatePosition(DragUpdateDetails details){
    _position += Offset(details.delta.dx, 0);
    final x = _position.dx;
    _angle = 30 * x / _screenSize.width;
    _spacingHeight=32;
    notifyListeners();
  }
  void endPosition(){
    _isDragging = false;
    notifyListeners();


    String result = cardStatus() ?? "";
    if (result == "Like") {
      like();
      reset1Sec();
    print(result);
    }else if(result == "No"){
      no();
      reset1Sec();
      print(result);
    }else{
      reset();
    }


  }

  String? cardStatus (){
    final x = _position.dx;

    final delta = 100;
    print(x);
    if (x >= delta) {
      return "No";
    }else if(x <= -delta){
      return "Like";
    }else {
      return "";
    }

  }

  void like(){
    _angle = 90;
    _position += Offset((-0.5 * _screenSize.width), (1 * _screenSize.height));
    notifyListeners();
  }  
  void no(){
    _angle = 270;
    _position += Offset((0.5 * _screenSize.width), (0.75 * _screenSize.height));
    notifyListeners();
  }

  void reset() async {
    await Future.delayed(Duration(seconds: 0));
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    _spacingHeight=0;
    notifyListeners();

  }  
  void reset1Sec() async {
    await Future.delayed(Duration(seconds: 1));
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    _spacingHeight=0;
    notifyListeners();

  }

}