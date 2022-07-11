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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<BattleCardProvider>(context,listen: false);
      bool a = widget.cardPosition == CardPosition.Top;
      print("$a first set card == top" );
      provider.setDragging(a);
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
          print("üst tıklandı");
          context.read<BattleCardProvider>().setDragging(true);
        }else if(widget.cardPosition == CardPosition.Bottom ){
          print("alt tıklandı");
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
        child: widget.child
      ),
    );
  }
}