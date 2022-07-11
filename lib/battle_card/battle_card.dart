
import 'dart:math';
import 'package:custom_widgets/battle_card/battle_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CardPosition{ Top, Bottom }

class BattleCard extends StatefulWidget {
  const BattleCard({
    Key? key, 
    this.milliseconds = 3000, 
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
      provider.setDragging(widget.cardPosition == CardPosition.Top);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return battleCard();
  }

  Widget battleCard() {
    return GestureDetector(
      onPanDown: (details) {
        if (widget.cardPosition == CardPosition.Top ) {
          context.read<BattleCardProvider>().setDragging(true);
        }else if(widget.cardPosition == CardPosition.Bottom ){
          context.read<BattleCardProvider>().setDragging(false);
        }
      },
      onTap: (){
        //TODO: DIŞARDAN AL
      },
      onPanStart: (details) {
        context.read<BattleCardProvider>().startPosition(details);
      },
      onPanUpdate: (details){
        context.read<BattleCardProvider>().updatePosition(details);
        //DragUpdateDetails detail = DragUpdateDetails(delta: -(details.delta),globalPosition: Offset.zero,); //

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
          final center = cardPost == CardPosition.Top ? constraints.biggest.topCenter(Offset.zero) : constraints.biggest.bottomCenter(Offset.zero);;
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
    final status = context.watch<BattleCardProvider>().getTopCardStatus();

    switch (status) {
      case CardStatus.Win: return widget.cardPosition == CardPosition.Top ? win() : lose();
      case CardStatus.Lose: return widget.cardPosition == CardPosition.Top ? lose() : win();
      case null: return SizedBox.shrink();
      default: return SizedBox.shrink();
    }
  }

  Widget win(){
    final opacity = context.watch<BattleCardProvider>().getOpacity();
    final status = context.watch<BattleCardProvider>().getTopCardStatus();
      bool isTopCard = widget.cardPosition == CardPosition.Top;
      bool isWin = status == CardStatus.Win;
      bool isLose = status == CardStatus.Lose;
      bool isNull = status == null;
    return Opacity(
      opacity: opacity,
      child: Container(
        color: Colors.green.withOpacity(0.7),
        child: isNull == true 
        ? null
        : isWin 
          ? isTopCard ? winColumn() :loseColumn()
          : isTopCard ? loseColumn() :winColumn()
      ),
    );
  }

  Widget lose(){
    final opacity = context.watch<BattleCardProvider>().getOpacity();
    final status = context.watch<BattleCardProvider>().getTopCardStatus();

      bool isTopCard = widget.cardPosition == CardPosition.Top;
      bool isWin = status == CardStatus.Win;
      bool isLose = status == CardStatus.Lose;
      bool isNull = status == null;
    return Opacity(
      opacity: opacity,
      child: Container(
        color: Colors.red.withOpacity(0.7),
        child: isNull == true 
        ? null
        : isWin 
          ? isTopCard ? winColumn() :loseColumn()
          : isTopCard ? loseColumn() :winColumn()
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