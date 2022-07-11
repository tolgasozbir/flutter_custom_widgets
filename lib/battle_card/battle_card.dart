import 'dart:math';
import 'package:custom_widgets/battle_card/battle_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CardPosition{ Top, Bottom }

class BattleCard extends StatefulWidget {
  const BattleCard({
    Key? key, 
    this.milliseconds = 400, 
    required this.child, required this.cardPosition,
  }) : super(key: key);

  final CardPosition cardPosition;
  final int milliseconds;
  final Widget child;

  @override
  State<BattleCard> createState() => _BattleCardState();
}

class _BattleCardState extends State<BattleCard> {

  TextStyle winLoseTextStyle = TextStyle(fontSize: 48,fontWeight: FontWeight.bold ,color: Colors.white);
  double iconSize = 128;
  Color iconColor = Colors.white;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<BattleCardProvider>(context,listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return battleCard();
  }

  Widget battleCard() {
    return GestureDetector(
      onTap: (){
        
      },
      onPanStart: (details) {
        context.read<BattleCardProvider>().startPosition(details);
      },
      onPanUpdate: (details){
        context.read<BattleCardProvider>().updatePosition(details);
      },      
      onPanEnd: (details){
        context.read<BattleCardProvider>().endPosition();
      },      
      child: LayoutBuilder(
        builder: (context,constraints) {
          var cardPost = widget.cardPosition;
          final provider = Provider.of<BattleCardProvider>(context);
          final position = cardPost == CardPosition.Top ? provider.getTopCardPosition : provider.getBottomCardPosition;
          final duration = provider.isDragging ? 0 : widget.milliseconds;
          final angle = cardPost == CardPosition.Top ? provider.getTopCardAngle * pi / 180 : provider.getBottomCardAngle * pi / 180;
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            cardStamps()
          ],
        )
      ),
    );
  }

    Widget cardStamps(){
    final status = context.watch<BattleCardProvider>().getBottomCardStatus();
    var cardPos = widget.cardPosition;
    switch (status) {
      case CardStatus.Win: return cardPos == CardPosition.Bottom ? win() : lose();
      case CardStatus.Lose: return cardPos == CardPosition.Bottom ? lose() : win();
      case null: return SizedBox.shrink();
      default: return SizedBox.shrink();
    }
  }

  Widget win(){
    final opacity = context.watch<BattleCardProvider>().getOpacity();
    return Opacity(
      opacity: opacity,
      child: Container(
        color: Colors.green.withOpacity(0.7),
        child: winColumn(),
      ),
    );
  }  
  
  Widget lose(){
    final opacity = context.watch<BattleCardProvider>().getOpacity();
    return Opacity(
      opacity: opacity,
      child: Container(
        color: Colors.red.withOpacity(0.7),
        child: loseColumn(),
      ),
    );
  }


  Column winColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle_outlined,size: iconSize,color: iconColor,),
        Text("Win!",style: winLoseTextStyle)
      ],
    );
  }    
  
  Column loseColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cancel_outlined,size: iconSize,color: iconColor,),
        Text("Lose",style: winLoseTextStyle)
      ],
    );
  }  
}