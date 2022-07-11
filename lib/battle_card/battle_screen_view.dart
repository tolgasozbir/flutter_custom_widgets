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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Column(
      children: [   
        Expanded(
          child: BattleCard(
            cardPosition: CardPosition.Top,
            child: Image.network("https://picsum.photos/400/400?random=1",fit: BoxFit.cover,),
          ),
        ),
        spacerDivider(),
        Expanded(
          child: BattleCard(
            cardPosition: CardPosition.Bottom,
            child: Image.network("https://picsum.photos/400/400?random=2",fit: BoxFit.cover,),
          ),
        ),
      ],
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