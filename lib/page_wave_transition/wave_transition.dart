import 'package:flutter/material.dart';

class WaveTransition extends StatelessWidget {
  const WaveTransition({
    Key? key, 
    required this.duration, 
    required this.fractionalOffset, 
    required this.child,
  }) : super(key: key);

  final Duration duration;
  final FractionalOffset fractionalOffset;
  final Widget child;
  

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: this.duration,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context,double value,child){
        return ShaderMask(
          blendMode: BlendMode.modulate,
          shaderCallback: (rect){
            return RadialGradient(
              radius: value * 5,
              colors: [
                Colors.white,
                Colors.white,
                Colors.transparent,
                Colors.transparent
              ],
              stops: [0.0, 0.55, 0.6, 1.0],
              center: this.fractionalOffset
            ).createShader(rect);
          },
        child: this.child,);
      },
    );
  }
}