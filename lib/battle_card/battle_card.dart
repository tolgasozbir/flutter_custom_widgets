import 'dart:math';
import 'package:custom_widgets/battle_card/battle_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CardPosition{ Top, Bottom }

class BattleCard extends StatefulWidget {
  const BattleCard({
    Key? key, 
    required this.cardPosition, 
    this.milliseconds = 400, 
    this.onTap,
    required this.child, 
    this.cardWinStamp, 
    this.cardLoseStamp, 
    this.cardResults,
  }) : super(key: key);

  final CardPosition cardPosition;
  final int milliseconds;
  final VoidCallback? onTap;
  final Widget child;
  final Widget? cardWinStamp;
  final Widget? cardLoseStamp;
  final void Function(bool? didBottomCardWin)? cardResults;

  @override
  State<BattleCard> createState() => _BattleCardState();
}

class _BattleCardState extends State<BattleCard> {
  
  late final CardPosition cardPosition;
  
  @override
  void initState() {
    super.initState();
    cardPosition = widget.cardPosition;
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
      onTap: widget.onTap,
      onPanStart: (details) {
        context.read<BattleCardProvider>().startPosition(details);
      },
      onPanUpdate: (details){
        context.read<BattleCardProvider>().updatePosition(details);
      },      
      onPanEnd: (details){
        context.read<BattleCardProvider>().endPosition();
        bool? result = context.read<BattleCardProvider>().didBottomCardWin;;
        widget.cardResults?.call(result);
      },      
      child: LayoutBuilder(
        builder: (context,constraints) {
          final provider = Provider.of<BattleCardProvider>(context);
          final position = cardPosition == CardPosition.Top ? provider.getTopCardPosition : provider.getBottomCardPosition;
          final duration = provider.isDragging ? 0 : widget.milliseconds;
          final angle = cardPosition == CardPosition.Top ? provider.getTopCardAngle * pi / 180 : provider.getBottomCardAngle * pi / 180;
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

    Widget winStamp =  widget.cardWinStamp != null 
      ? widget.cardWinStamp! 
      : stamp(
        color: Colors.green.withOpacity(0.7), 
        text: "Win!", 
        icon: Icons.check_circle_outlined
      );

    Widget loseStamp = widget.cardLoseStamp != null 
      ? widget.cardLoseStamp! 
      : stamp(
        color: Colors.red.withOpacity(0.7), 
        text: "Lose", 
        icon: Icons.cancel_outlined
      );

    switch (status) {
      case CardStatus.Win: return cardPosition == CardPosition.Bottom ? winStamp : loseStamp;
      case CardStatus.Lose: return cardPosition == CardPosition.Bottom ? loseStamp : winStamp;
      default: return SizedBox.shrink();
    }
  }

  Widget stamp({
    required Color color, 
    required String text, 
    required IconData icon, 
    double? iconSize = 128, 
    Color? iconColor=Colors.white,
    TextStyle textStyle= const TextStyle(fontSize: 48,fontWeight: FontWeight.bold ,color: Colors.white)
  }) {
    final opacity = context.watch<BattleCardProvider>().getOpacity();
    return Opacity(
      opacity: opacity,
      child: Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,size: iconSize,color: iconColor,),
            Text("$text",style: textStyle)
          ],
        ),
      ),
    ); 
  }

}