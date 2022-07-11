import 'dart:math';

import 'package:custom_widgets/battle_card/cardprovider.dart';
import 'package:custom_widgets/battle_card/provider2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BattleCard2 extends StatefulWidget {
  const BattleCard2({
    Key? key, 
    this.milliseconds = 400, 
    required this.child,
  }) : super(key: key);

  final int milliseconds;
  final Widget child;

  @override
  State<BattleCard2> createState() => _BattleCard2State();
}

class _BattleCard2State extends State<BattleCard2> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider2>(context,listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return battleCard();
  }

  Widget battleCard() {
    return GestureDetector(
      onPanStart: (details) {
        context.read<CardProvider2>().startPosition(details);
        context.read<CardProvider>().startPosition(details);
      },
      onPanUpdate: (details){
        context.read<CardProvider2>().updatePosition(details);
        DragUpdateDetails detail = DragUpdateDetails(delta: -(details.delta),globalPosition: Offset.zero,);
        context.read<CardProvider>().updatePosition(detail);
      },      
      onPanEnd: (details){
        context.read<CardProvider2>().endPosition();
        context.read<CardProvider>().endPosition();
      },      
      child: LayoutBuilder(
        builder: (context,constraints) {
          final provider = Provider.of<CardProvider2>(context);
          final position = provider.getPosition;
          final duration = provider.isDragging ? 0 : widget.milliseconds;
          final angle = provider.angle * pi / 180;
          final center = constraints.biggest.center(Offset.zero);
          final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(angle)
          ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: duration),
            transform: rotatedMatrix..translate(position.dx, position.dy),
            child: cardBody(),
          );
        },
      ),
    );
  }

  Widget cardBody(){
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: widget.child,
      ),
    );
  }
}