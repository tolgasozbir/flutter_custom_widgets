import 'package:custom_widgets/battle_card/battle_card.dart';
import 'package:custom_widgets/battle_card/battle_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BattleScreenView extends StatefulWidget {
  const BattleScreenView({Key? key}) : super(key: key);

  @override
  State<BattleScreenView> createState() => _BattleScreenViewState();
}

class _BattleScreenViewState extends State<BattleScreenView> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _bodyView()),
    );
  }

  Widget _bodyView() {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage("https://designshack.net/wp-content/uploads/best-subtle-black-white-background-textures.jpg"),fit: BoxFit.cover)
      ),
      child: Column(
        children: [   
          Expanded(
            child: BattleCard(
              cardPosition: CardPosition.Top,
              child: Image.network("https://picsum.photos/400/400?random=${index % 2 == 0 ? index : index+2}",fit: BoxFit.cover,),
            ),
          ),
          spacerDivider(),
          Expanded(
            child: BattleCard(
            cardPosition: CardPosition.Bottom,
              child: Image.network("https://picsum.photos/400/400?random=${index % 2 == 1 ? index : index+2}",fit: BoxFit.cover,),
              cardResults: (bool? didBottomCardWin) async {
                print("didBottomCardWin $didBottomCardWin");
                if (didBottomCardWin != null) {
                  await Future.delayed(Duration(milliseconds: 400));
                  setState(() {
                    index++;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer spacerDivider() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: Colors.amber.withOpacity(0.2),
      width: double.infinity,
      height: context.watch<BattleCardProvider>().spacingHeight,
    );
  }
}