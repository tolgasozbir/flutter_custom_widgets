import 'dart:math';

import 'package:custom_widgets/test/cardprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCArd extends StatefulWidget {
  const MyCArd({Key? key}) : super(key: key);

  @override
  State<MyCArd> createState() => _MyCArdState();
}

class _MyCArdState extends State<MyCArd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return SizedBox.expand(
      child: Column(
        children: [   
          Expanded(
            child: RotatedBox(quarterTurns: 0, child: bCard(index: 1,)),
          ),
          spaceAnimated(),
          Expanded(
            child: RotatedBox(quarterTurns: 2, child: bCard(index: 2)),
          ),
        ],
      ),
    );
  }

  AnimatedContainer spaceAnimated() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: Colors.amber.withOpacity(0.2),
      width: double.infinity,
      height: context.watch<CardProvider>().spacingHeight,
    );
  }

}

class bCard extends StatefulWidget {
  const bCard({
    Key? key, required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<bCard> createState() => _bCardState();
}

class _bCardState extends State<bCard> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context,listen: false);
      provider.setScreenSize(size);

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        context.read<CardProvider>().startPosition(details);
      },
      onPanUpdate: (details){
        context.read<CardProvider>().updatePosition(details);
      },      
      onPanEnd: (details){
        context.read<CardProvider>().endPosition();
      },      
      child: LayoutBuilder(
        builder: (context,constraints) {
          final provider = Provider.of<CardProvider>(context);
          final position = provider.getPosition;
          final millisecond = provider.isDragging ? 0 : 400;
          final angle = provider.angle * pi / 180;
          final center = constraints.biggest.bottomCenter(Offset.zero);
          final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(angle)
          ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: millisecond),
          transform: rotatedMatrix..translate(position.dx, position.dy),
          child: Stack(children: [
            aCard(),
            widget.index % 2 == 1 ? aCardStamps() : RotatedaCardStamps(),
          ],),
        );
        },
      ),
    );
  }

  Widget aCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: widget.index % 2 == 1 ? image() : rotatedText()
      ),
    );
  }

  RotatedBox rotatedText() => RotatedBox(quarterTurns: 2,child: image(),);

  Widget image(){
    return Image.network("https://picsum.photos/400/400?random=${widget.index}",fit: BoxFit.cover,color: Colors.black26,colorBlendMode: BlendMode.srcOver,);
  }

  Widget aCardStamps(){
    final provider = Provider.of<CardProvider>(context);
    final status = provider.cardStatus();

    if (status == "Like") {
      return  stamp(color: Colors.red, text: "No");
    }else if(status == "No"){
      return  stamp(color: Colors.green, text: "Like");
    }
    else{
      return SizedBox.shrink();
    }
  }  
  
  Widget RotatedaCardStamps(){
    final provider = Provider.of<CardProvider>(context);
    final status = provider.cardStatus();

    if (status == "Like") {
      return  RotatedBox(quarterTurns: 2, child: stamp(color: Colors.green, text: "Like"));
    }else if(status == "No"){
      return  RotatedBox(quarterTurns: 2, child: stamp(color: Colors.red, text: "No"));
    }
    else{
      return SizedBox.shrink();
    }
  }

  Widget stamp({double angle = 0,required Color color,required String text}){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.5)
      ),
      child: Center(child: Text(text,style: TextStyle(color: color,fontSize: 48,fontWeight: FontWeight.bold),),),
    );
  }
}

/*
          Card(
            child: widget.index % 2 == 1 ? image() : rotatedText()
          ),
*/