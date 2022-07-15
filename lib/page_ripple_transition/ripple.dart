import 'package:flutter/material.dart';

class RippleEffect extends StatefulWidget {
  const RippleEffect({
    Key? key, 
    required this.page, 
    required this.screenHeight, 
    required this.controller, 
    this.animationDuration = const Duration(milliseconds: 1000),

  }) : super(key: key);

  final double screenHeight;
  final Widget page;
  final Function(AnimationController rippleAnimationController) controller;
  final Duration animationDuration;

  @override
  State<RippleEffect> createState() => RippleEffectState();
}

class RippleEffectState extends State<RippleEffect> with SingleTickerProviderStateMixin {

  late final AnimationController _rippleAnimationController;
  late final Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _rippleAnimationController = AnimationController(vsync: this, duration: widget.animationDuration);
    _rippleAnimation = Tween<double>(begin: 0.0, end: widget.screenHeight).animate(
      CurvedAnimation(
        parent: _rippleAnimationController,
        curve: Curves.easeIn,
      )
    );
    widget.controller(_rippleAnimationController);
  }

  void forwardRipple(){
    _rippleAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.page,
        _rippleAnimatedBuilder()
      ],
    );
  }

  AnimatedBuilder _rippleAnimatedBuilder() {
    return AnimatedBuilder(
      animation: _rippleAnimationController, 
      builder: (_,child){
        return _Ripple(radius: _rippleAnimation.value);
      }
    );
  }
}

class _Ripple extends StatelessWidget {
  final double radius;

  const _Ripple({
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      left: screenWidth / 2 - radius,
      bottom: 2 * 32 - radius,
      child: Container(
        width: 2 * radius,
        height: 2 * radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}